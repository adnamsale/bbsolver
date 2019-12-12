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
        let state = SlitherlinkState(dim)
        setPatterns(state)
        dumpState(board, state)
        return searchSolve(state)
    }
    
    private func dumpState(_ board:SlitherlinkBoard, _ state:SlitherlinkState) {
        for i in 0..<dim {
            var strSep:String = "+"
            var strClue:String = state.ver[0][i + 1] == true ? "|" : state.ver[0][i + 1] == false ? "x": " "
            for j in 0..<dim {
                if state.hor[i][j + 1] == true {
                    strSep = strSep + "-"
                }
                else if state.hor[i][j + 1] == false {
                    strSep = strSep + "x"
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
                strClue += state.ver[j + 1][i + 1] == true ? "|" : state.ver[j + 1][i + 1] == false ? "x": " "
            }
            NSLog(strSep)
            NSLog(strClue)
        }
        var strSep:String = "+"
        for j in 0..<dim {
            if state.hor[dim][j + 1] == true {
                strSep = strSep + "-"
            }
            else if state.hor[dim][j + 1] == false {
                strSep = strSep + "x"
            }
            else {
                strSep = strSep + " "
            }
            strSep = strSep + "+"
        }
        NSLog(strSep)
    }
    
    private func searchSolve(_ state:SlitherlinkState) -> Bool {
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
                        fillCell(state, i, j, true, &answer)
                    }
                    if trueCount == clue && falseCount < 4 - clue {
                        fillCell(state, i, j, false, &answer);
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
                else if (2 == falseCount) {
                    if (1 == trueCount) {
                        fillNode(state, i, j, true, &answer)
                    }
                }
            }
        }
        return answer
    }
    
    private func fillCell(_ state:SlitherlinkState, _ i:Int, _ j:Int, _ value:Bool, _ moves:inout [SlitherlinkMove]) {
        if nil == state.hor[i][j + 1] {
            moves.append(SlitherlinkMove(Direction.HOR, i, j + 1, value))
        }
        if nil == state.hor[i + 1][j + 1] {
            moves.append(SlitherlinkMove(Direction.HOR, i + 1, j + 1, value))
        }
        if nil == state.ver[j][i + 1] {
            moves.append(SlitherlinkMove(Direction.VER, j, i + 1, value))
        }
        if nil == state.ver[j + 1][i + 1] {
            moves.append(SlitherlinkMove(Direction.VER, j + 1, i + 1, value))
        }
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
    
    private func setPatterns(_ state:SlitherlinkState) {
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
        // Adjacent 3s
        for i in 0..<dim - 1 {
            for j in 0..<dim {
                if board.clue(i, j) == 3 && board.clue(i + 1, j) == 3 {
                    state.hor[i][j + 1] = true
                    state.hor[i + 1][j + 1] = true
                    state.hor[i + 2][j + 1] = true
                    state.hor[i + 1][j] = false
                    state.hor[i + 1][j + 2] = false
                }
            }
        }
        for i in 0..<dim {
            for j in 0..<dim - 1 {
                if board.clue(i, j) == 3 && board.clue(i, j + 1) == 3 {
                    state.ver[j][i + 1] = true
                    state.ver[j + 1][i + 1] = true
                    state.ver[j + 2][i + 1] = true
                    state.ver[j + 1][i] = false
                    state.ver[j + 1][i + 2] = false
                }
            }
        }
        // Diagonal 3s
        for i in 0..<dim - 1 {
            for j in 0..<dim - 1 {
                if board.clue(i,j) == 3 {
                    var i1 = i + 1
                    var j1 = j + 1
                    while (i1 < dim && j1 < dim && board.clue(i1, j1) == 2) {
                        i1 = i1 + 1
                        j1 = j1 + 1
                    }
                    if (i1 < dim && j1 < dim && board.clue(i1, j1) == 3) {
                        state.hor[i][j + 1] = true
                        state.hor[i1 + 1][j1 + 1] = true
                        state.ver[j][i + 1] = true
                        state.ver[j1 + 1][i1 + 1] = true
                    }
                }
            }
        }
        for i in 0..<dim - 1 {
            for j in 1..<dim {
                if board.clue(i, j) == 3 {
                    var i1 = i + 1
                    var j1 = j - 1
                    while (i1 < dim && 0 <= j1 && board.clue(i1, j1) == 2) {
                        i1 = i1 + 1
                        j1 = j1 - 1
                    }
                    if (i1 < dim && 0 <= j1 && board.clue(i1, j1) == 3) {
                        state.hor[i][j + 1] = true
                        state.hor[i1 + 1][j1 + 1] = true
                        state.ver[j + 1][i + 1] = true
                        state.ver[j1][i1 + 1] = true
                    }
                }
            }
        }
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
}
