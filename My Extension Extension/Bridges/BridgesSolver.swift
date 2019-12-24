//
//  BridgesSolver.swift
//  My Extension Extension
//
//  Created by mark on 12/23/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

class BridgesSolver {
    private let board:BridgesBoard
    
    init(_ board:BridgesBoard) {
        self.board = board
    }
    
    let ONELINE = 1
    let TWOLINES = 2
    let NOLINES = 4
    
    var solution:String = ""
    
    private struct Move {
        let line:Int
        let oldValue:Int
        let newValue:Int
    }
    
    func solve() -> Bool {
        var state:[Int] = Array.init(repeating: NOLINES + ONELINE + TWOLINES, count: board.lines.count)
        if solveRecurse(&state) {
            buildSolution(state)
            return true
        }
        return false
    }
    
    private func buildSolution(_ state:[Int]) {
        var chars:[Character] = Array.init(repeating: " ", count: board.dim * board.dim)
        for i in 0..<state.count {
            var c:Character = " "
            let isHor:Bool = board.lines[i].clueStart.i == board.lines[i].clueEnd.i
            if state[i] == ONELINE {
                c = isHor ? "-" : "i"
            }
            else if state[i] == TWOLINES {
                c = isHor ? "=" : "n"
            }
            else {
                continue
            }
            let delta = isHor ? 1 : board.dim
            var pos = board.lines[i].clueStart.i * board.dim + board.lines[i].clueStart.j + delta
            let end = board.lines[i].clueEnd.i * board.dim + board.lines[i].clueEnd.j
            while pos < end {
                chars[pos] = c
                pos += delta
            }
        }
        solution = String(chars)
    }
    
    private func solveRecurse(_ state:inout [Int]) -> Bool {
        if let moves = findForcedMoves(state) {
            if 0 != moves.count {
                if !applyMoves(&state, moves) {
                    rollbackMoves(&state, moves)
                    return false
                }
                let answer = solveRecurse(&state)
                if (!answer) {
                    rollbackMoves(&state, moves)
                }
                return answer
            }
        }
        else {
            return false
        }
        // No forced moves, so just find the next move
        for i in 0..<state.count {
            if ONELINE == state[i] || TWOLINES == state[i] || NOLINES == state[i]{
                continue
            }
            let safe = state[i]
            for move in [TWOLINES, ONELINE, NOLINES] {
                if 0 != state[i] & move {
                    state[i] = move
                    if solveRecurse(&state) {
                        return true
                    }
                    state[i] = safe
                }
            }
            return false
        }
        return true
    }
    
    private func findForcedMoves(_ state:[Int]) -> [Move]? {
        var answer:[Move] = []
        for line in 0..<state.count {
            if (state[line] == ONELINE || state[line] == TWOLINES) {
                for cross in board.crossingLines[line] {
                    if state[cross] != NOLINES {
                        if !appendMove(state, cross, NOLINES, &answer) {
                            return nil
                        }
                    }
                }
            }
        }
        for clue in board.clues {
            var currentTotal:Int = 0
            var remainingLines:[Int] = []
            for line in clue.lines {
                switch (state[line]) {
                case ONELINE:
                    currentTotal = currentTotal + 1
                    break
                case TWOLINES:
                    currentTotal = currentTotal + 2
                    break;
                case NOLINES:
                    // currentTotal = currentTotal + 0
                    break;
                default:
                    remainingLines.append(line)
                }
            }
            if clue.clue < currentTotal {
                return nil
            }
            if (clue.clue == currentTotal && 0 != remainingLines.count) {
                for line in remainingLines {
                    if !appendMove(state, line, NOLINES, &answer) {
                        return nil
                    }
                }
            }
            if currentTotal < clue.clue && 0 == remainingLines.count {
                return nil
            }
            if currentTotal < clue.clue && 1 == remainingLines.count {
                let line = remainingLines.first!
                if 1 == clue.clue - currentTotal {
                    if !appendMove(state, line, ONELINE, &answer) {
                        return nil
                    }
                }
                else if 2 == clue.clue - currentTotal {
                    if !appendMove(state, line, TWOLINES, &answer) {
                        return nil
                    }
                }
                else {
                    return nil
                }
            }
        }
        return answer
    }
    
    private func appendMove(_ state:[Int], _ line:Int, _ newValue:Int, _ moves:inout [Move]) -> Bool {
        if 0 == state[line] & newValue {
            return false
        }
        moves.append(Move(line:line, oldValue:state[line], newValue:newValue))

        return true;
    }
    
    private func applyMoves(_ state:inout [Int], _ moves:[Move]) -> Bool {
        for move in moves {
            if 0 == state[move.line] & move.newValue {
                return false
            }
            state[move.line] = move.newValue
        }
        return true
    }
    
    private func rollbackMoves(_ state:inout [Int], _ moves:[Move]) {
        for move in moves {
            state[move.line] = move.oldValue
        }
    }
}
