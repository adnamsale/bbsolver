//
//  SlitherlinkSolver.swift
//  My Extension Extension
//
//  Created by mark on 11/27/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

// For cell[row = i, col = j] with 0 <= i,j < dim
// Horizontal bar above cell is hor[i][j + 1]
// Horizontal bar below cell is hor[i + 1][j + 1]
// Vertical bar left of cell is ver[j][i + 1]
// Vertical bar right of cell is ver[j + 1][i + 1]
class SlitherlinkState {
    var hor:[[Bool?]] = []
    var ver:[[Bool?]] = []
    
    init(_ dim:Int) {
        for i in 0...dim {
            hor.append(Array.init(repeating:nil, count:dim + 2))
            hor[i][0] = false
            hor[i][dim + 1] = false
            ver.append(Array.init(repeating:nil, count:dim + 2))
            ver[i][0] = false
            ver[i][dim + 1] = false
        }
    }
    
    @discardableResult
    func setHorIfNil(_ i:Int, _ j:Int, _ value:Bool) -> Bool {
        if (hor[i][j] == nil) {
            hor[i][j] = value
            return true
        }
        return false
    }
    
    @discardableResult
    func setVerIfNil(_ i:Int, _ j:Int, _ value:Bool) -> Bool {
        if (ver[i][j] == nil) {
            ver[i][j] = value
            return true
        }
        return false
    }
    
    func set(_ dir:Direction, _ i:Int, _ j:Int, _ value:Bool?) {
        if (dir == Direction.HOR) {
            hor[i][j] = value
        }
        else {
            ver[i][j] = value
        }
    }
}

enum Direction {
    case HOR
    case VER
}

class SlitherlinkMove {
    let i:Int
    let j:Int
    let value:Bool
    let dir:Direction
        
    init(_ dir:Direction, _ i:Int, _ j:Int, _ value:Bool) {
        self.dir = dir
        self.i = i
        self.j = j
        self.value = value
    }
}

class SlitherlinkSolver {
    let board:SlitherlinkBoard
    let dim:Int
    var solution:[String:String] = [:]
    
    init(board:SlitherlinkBoard) {
        self.board = board
        self.dim = board.dim
    }
    
    func solve() -> Bool {
//        logicSolve()
        return searchSolve()
    }
    
    private func dumpState(_ board:SlitherlinkBoard, _ state:SlitherlinkState) {
        for i in 0..<dim {
            var strSep:String = "+"
            var strClue:String = state.ver[0][i + 1] == true ? "|" : " "
            for j in 0..<dim {
                if state.hor[i][j + 1] == true {
                    strSep = strSep + "-"
                }
                else {
                    strSep = strSep + " "
                }
                if let clue = board.clue(i, j) {
                    strClue += String(clue)
                }
                else {
                    strClue += " "
                }
                strSep += "+"
                strClue += state.ver[j + 1][i + 1] == true ? "|" : " "
            }
            NSLog(strSep)
            NSLog(strClue)
        }
        var strSep:String = "+"
        for j in 0..<dim {
            if state.hor[dim][j + 1] == true {
                strSep = strSep + "-"
            }
            else {
                strSep = strSep + " "
            }
            strSep = strSep + "+"
        }
        NSLog(strSep)
    }
    
    private func searchSolve() -> Bool {
        let state = SlitherlinkState(dim)
        if solveRecurse(state) {
            dumpState(board, state)
            var hor:String = ""
            for i in 0...dim {
                for j in 1...dim {
                    var c:String
                    if (state.hor[i][j] == true) {
                        c = "y"
                    }
                    else if (state.hor[i][j] == false) {
                        c = "x"
                    }
                    else {
                        c = "n"
                    }
                    hor = hor + c
                }
            }
            solution["hor"] = hor
            var ver:String = ""
            for j in 1...dim {
                for i in 0...dim {
                    var c:String
                    if (state.ver[i][j] == true) {
                        c = "y"
                    }
                    else if (state.ver[i][j] == false) {
                        c = "x"
                    }
                    else {
                        c = "n"
                    }
                    ver = ver + c
                }
            }
            solution["ver"] = ver
            
            return true
        }
        return false
    }
    
    private func solveRecurse(_ state:SlitherlinkState) -> Bool {
        if let moves = findForcedMoves(state) {
            if 0 != moves.count {
                for move in moves {
                    state.set(move.dir, move.i, move.j, move.value)
                }
                let answer = solveRecurse(state)
                if (!answer) {
                    for move in moves {
                        state.set(move.dir, move.i, move.j, nil)
                    }
                }
                return answer
            }
        }
        else {
            return false
        }
        // No forced moves, so just find the next move
        for i in 0...dim {
            for j in 1...dim {
                if (state.hor[i][j] == nil) {
                    state.hor[i][j] = true
                    if solveRecurse(state) {
                        return true
                    }
                    state.hor[i][j] = false
                    if solveRecurse(state) {
                        return true
                    }
                    state.hor[i][j] = nil
                    return false
                }
                if (state.ver[i][j] == nil) {
                    state.ver[i][j] = true
                    if solveRecurse(state) {
                        return true
                    }
                    state.ver[i][j] = false
                    if solveRecurse(state) {
                        return true
                    }
                    state.ver[i][j] = nil
                    return false
                }
            }
        }
        return true
    }
    
    // Returns nil if we determine the board is invalid. Otherwise returns a list of moves
    // required to ensure flow or cell count consistency or an empty list if no such move exists
    private func findForcedMoves(_ state:SlitherlinkState) -> [SlitherlinkMove]? {
        var answer:[SlitherlinkMove] = []
        // Cell clues
        for i in 0..<dim {
            for j in 0..<dim {
                if let clue = board.clue(i, j) {
                    let trueCount = countBorder(state, i, j, true)
                    let falseCount = countBorder(state, i, j, false)
                    if (clue < trueCount || 4 - clue < falseCount) {
                        return nil
                    }
                    if falseCount + clue == 4 && trueCount < clue {
                        if nil == state.hor[i][j + 1] {
                            answer.append(SlitherlinkMove(Direction.HOR, i, j + 1, true))
                        }
                        if nil == state.hor[i + 1][j + 1] {
                            answer.append(SlitherlinkMove(Direction.HOR, i + 1, j + 1, true))
                        }
                        if nil == state.ver[j][i + 1] {
                            answer.append(SlitherlinkMove(Direction.VER, j, i + 1, true))
                        }
                        if nil == state.ver[j + 1][i + 1] {
                            answer.append(SlitherlinkMove(Direction.VER, j + 1, i + 1, true))
                        }
                    }
                    if trueCount == clue && falseCount < 4 - clue {
                        if nil == state.hor[i][j + 1] {
                            answer.append(SlitherlinkMove(Direction.HOR, i, j + 1, false))
                        }
                        if nil == state.hor[i + 1][j + 1] {
                            answer.append(SlitherlinkMove(Direction.HOR, i + 1, j + 1, false))
                        }
                        if nil == state.ver[j][i + 1] {
                            answer.append(SlitherlinkMove(Direction.VER, j, i + 1, false))
                        }
                        if nil == state.ver[j + 1][i + 1] {
                            answer.append(SlitherlinkMove(Direction.VER, j + 1, i + 1, false))
                        }
                    }
                }
            }
        }
        // Node flow
        for i in 0...dim {
            for j in 0...dim {
                let trueCount = countNode(state, i, j, true)
                let falseCount = countNode(state, i, j, false)
                if (2 < trueCount) {
                    return nil
                }
                else if (3 == falseCount) {
                    if (1 == trueCount) {
                        return nil
                    }
                    fillNode(state, i, j, false, &answer)
                }
                else if (2 == trueCount) {
                    if (2 != falseCount) {
                        fillNode(state, i, j, false, &answer)
                    }
                }
            }
        }
        return answer
    }
    
    private func fillNode(_ state:SlitherlinkState, _ i:Int,_ j:Int, _ value:Bool, _ moves:inout [SlitherlinkMove]) {
        if (state.hor[i][j] == nil) {
            moves.append(SlitherlinkMove(Direction.HOR, i, j, value))
        }
        else if (state.hor[i][j + 1] == nil) {
            moves.append(SlitherlinkMove(Direction.HOR, i, j + 1, value))
        }
        else if (state.ver[j][i] == nil) {
            moves.append(SlitherlinkMove(Direction.VER, j, i, value))
        }
        else if (state.ver[j][i + 1] == nil) {
            moves.append(SlitherlinkMove(Direction.VER, j, i + 1, value))
        }
    }
    
    private func logicSolve() {
        let state = SlitherlinkState(dim)
        
        // Zeros
        for i in 0..<board.dim {
            for j in 0..<board.dim {
                if (board.clue(i, j) == 0) {
                    state.hor[i][j + 1] = false
                    state.hor[i + 1][j + 1] = false
                    state.ver[j][i + 1] = false
                    state.ver[j + 1][i + 1] = false
                }
            }
        }
        
        // Corners
        switch board.clue(0,0) {
        case 1:
            state.hor[0][1] = false
            state.ver[0][1] = false
            break
        case 2:
            state.hor[0][2] = true
            state.ver[0][2] = true
            break
        case 3:
            state.hor[0][1] = true
            state.ver[0][1] = true
            break
        default:
            break
        }
        switch board.clue(0, dim - 1) {
        case 1:
            state.hor[0][dim] = false
            state.ver[dim][1] = false
            break
        case 2:
            state.hor[0][dim - 1] = true
            state.ver[dim][2] = true
            break
        case 3:
            state.hor[0][dim] = true
            state.ver[dim][1] = true
            break
        default:
            break
        }
        switch board.clue(dim - 1, 0) {
        case 1:
            state.hor[dim][1] = false
            state.ver[0][dim] = false
            break
        case 2:
            state.hor[dim][2] = true
            state.ver[0][dim - 1] = true
            break
        case 3:
            state.hor[dim][1] = true
            state.ver[0][dim] = true
            break
        default:
            break
        }
        switch board.clue(dim - 1, dim - 1) {
        case 1:
            state.hor[dim][dim] = false
            state.ver[dim][dim] = false
            break
        case 2:
            state.hor[dim][dim - 1] = true
            state.ver[dim][dim - 1] = true
            break
        case 3:
            state.hor[dim][dim] = true
            state.ver[dim][dim] = true
            break
        default:
            break
        }
        while (logicSolveRecurse(state)) {
        }
    }
    
    private func logicSolveRecurse(_ state:SlitherlinkState) -> Bool {
        if propagateDeadEnds(state) {
            return true
        }
        if fillClues(state) {
            return true
        }
        if propagateCorners(state) {
            return true
        }
        if extendLine(state) {
            return true
        }
        return false;
    }
    
    // If an intersection has 3 false paths then the 4th path can be set to false
    private func propagateDeadEnds(_ state:SlitherlinkState) -> Bool {
        for row in 0...dim {
            for col in 0...dim {
                let countFalse = countNode(state, row, col, false)
                if (3 == countFalse) {
                    state.hor[row][col] = false
                    state.hor[row][col + 1] = false
                    state.ver[col][row] = false
                    state.ver[col][row + 1] = false
                    return true
                }
            }
        }
        return false
    }
    
    private func countNode(_ state:SlitherlinkState, _ i:Int, _ j:Int, _ value:Bool) -> Int {
        var count = 0
        if (state.hor[i][j] == value) {
            count += 1
        }
        if (state.hor[i][j + 1] == value) {
            count += 1
        }
        if (state.ver[j][i] == value) {
            count += 1
        }
        if (state.ver[j][i + 1] == value) {
            count += 1
        }
        return count
    }
    
    private func countBorder(_ state:SlitherlinkState, _ i:Int, _ j:Int, _ value:Bool) -> Int {
        var count = 0;
        if (state.hor[i][j + 1] == value) {
            count += 1
        }
        if (state.hor[i + 1][j + 1] == value) {
            count += 1
        }
        if (state.ver[j][i + 1] == value) {
            count += 1
        }
        if (state.ver[j + 1][i + 1] == value) {
            count += 1
        }
        return count
    }
    
    // If we have enough false entries around a clue square, we can fill in the trues
    // E.g., if the clue is 3 and we have one false then we know the others must be true
    private func fillClues(_ state:SlitherlinkState) -> Bool {
        for i in 0..<dim {
            for j in 0..<dim {
                if let clue = board.clue(i, j) {
                    let countFalse = countBorder(state, i, j, false)
                    let countTrue = countBorder(state, i, j, true)
                    if (countFalse + clue == 4 && clue != countTrue) {
                        state.setHorIfNil(i, j + 1, true)
                        state.setHorIfNil(i + 1, j + 1, true)
                        state.setVerIfNil(j, i + 1, true)
                        state.setVerIfNil(j + 1, i + 1, true)
                        return true
                    }
                    else if (countFalse + clue != 4 && clue == countTrue) {
                        state.setHorIfNil(i, j + 1, false)
                        state.setHorIfNil(i + 1, j + 1, false)
                        state.setVerIfNil(j, i + 1, false)
                        state.setVerIfNil(j + 1, i + 1, false)
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func propagateCorners(_ state:SlitherlinkState) -> Bool {
        for row in 0...dim {
            for col in 0...dim {
                if (state.ver[col][row] == true && state.hor[row][col + 1] == true) {
                    var answer = state.setHorIfNil(row, col, false)
                    answer = state.setVerIfNil(col, row + 1, false) || answer
                    if (answer) {
                        return true
                    }
                }
                if (state.hor[row][col + 1] == true && state.ver[col][row + 1] == true) {
                    var answer = state.setHorIfNil(row, col, false)
                    answer = state.setVerIfNil(col, row, false) || answer
                    if (answer) {
                        return true
                    }
                }
                if (state.ver[col][row + 1] == true && state.hor[row][col] == true) {
                    var answer = state.setHorIfNil(row, col + 1, false)
                    answer = state.setVerIfNil(col, row, false) || answer
                    if (answer) {
                        return true
                    }
                }
                if (state.hor[row][col] == true && state.ver[col][row] == true) {
                    var answer = state.setHorIfNil(row, col + 1, false)
                    answer = state.setVerIfNil(col, row + 1, false) || answer
                    if (answer) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func extendLine(_ state: SlitherlinkState) -> Bool {
        for row in 0...dim {
            for col in 0...dim {
                let countFalse = countNode(state, row, col, false)
                let countTrue = countNode(state, row, col, true)
                if (2 == countFalse && 1 == countTrue) {
                    state.setHorIfNil(row, col, true)
                    state.setHorIfNil(row, col + 1, true)
                    state.setVerIfNil(col, row, true)
                    state.setVerIfNil(col, row + 1, true)
                    return true
                }
            }
        }
        return false
    }
}
