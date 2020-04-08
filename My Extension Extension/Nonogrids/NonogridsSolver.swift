//
//  NonogridsSolver.swift
//  My Extension Extension
//
//  Created by mark on 4/7/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class NonogridsSolver {
    class State {
        var cells:[[Bool?]]
        let dim:Int
        
        init(_ board:NonogridsBoard) {
            dim = board.dim
            cells = Array.init(repeating: Array.init(repeating:nil, count: dim),count:dim)
        }
        
        func getAcross(_ i:Int) -> ([Int], Bool) {
            return getProgress(i, 0, 0, 1)
        }
        
        func getDown(_ j:Int) -> ([Int], Bool) {
            return getProgress(0, j, 1, 0)
        }
        
        // For a row/column, returns the lengths of black runs in answer.0 and a boolean
        // showing whether the partial row/column ends with a white square in answer.1
        func getProgress(_ iStart:Int, _ jStart:Int, _ iDelta:Int, _ jDelta:Int) -> ([Int], Bool)
        {
            var answer:([Int], Bool) = ([], false)
            var runLength = 0
        
            var i = iStart
            var j = jStart
            while (i < dim && j < dim) {
                if cells[i][j] == nil {
                    break
                }
                else if cells[i][j] == true {
                    runLength = runLength + 1
                    answer.1 = false
                }
                else {
                    if 0 != runLength {
                        answer.0.append(runLength)
                        runLength = 0
                    }
                    answer.1 = true
                }
                i = i + iDelta
                j = j + jDelta
            }
            if 0 != runLength {
                answer.0.append(runLength)
            }
            return answer
        }
    }
    
    private let board:NonogridsBoard
    
    init(_ board:NonogridsBoard) {
        self.board = board
    }
    
    var solution:String = ""
    
    func solve() -> Bool {
        var state = State(board)
        if solveRecurse(&state) {
            for i in 0..<board.dim {
                for j in 0..<board.dim {
                    solution.append(state.cells[i][j]! ? "B" : "W")
                }
            }
            return true
        }
        return false
    }
    
    func solveRecurse(_ state:inout State) -> Bool {
        var answer = false
        for i in 0..<board.dim {
            for j in 0..<board.dim {
                if state.cells[i][j] == nil {
                    let (aActual, aTerm) = state.getAcross(i)
                    let aTarget:[Int] = board.getAcross(i)
                    let (aBlack, aWhite) = findMoves(aActual, aTarget, aTerm, board.dim - j)
                    let (dActual, dTerm) = state.getDown(j)
                    let dTarget:[Int] = board.getDown(j)
                    let (dBlack, dWhite) = findMoves(dActual, dTarget, dTerm, board.dim - i)
                    if aBlack && dBlack {
                        state.cells[i][j] = true
                        answer = solveRecurse(&state)
                    }
                    if !answer && aWhite && dWhite {
                        state.cells[i][j] = false
                        answer = solveRecurse(&state)
                    }
                    if (!answer) {
                        state.cells[i][j] = nil
                        return false
                    }
                    return true
                }
            }
        }
        return true
    }
    
    func findMoves(_ actual:[Int], _ target:[Int], _ term:Bool, _ remain:Int) -> (Bool, Bool) {
        // Quick guard check - if we don't have enough spaces remaining in the row/column to
        // meet the number of required black squares then there are no possible moves
        if actual.reduce(0, +) + remain < target.reduce(0, +) {
            return (false, false)
        }
        var answer:(Bool, Bool) = (false, false)
        if actual.count == target.count {
            answer.1 = (actual.last! == target.last!)
            answer.0 = !answer.1
        }
        else {
            if 0 == actual.count {
                answer.0 = true
                answer.1 = true
            }
            else if actual[actual.count - 1] < target[actual.count - 1] {
                answer.0 = true
                answer.1 = false
            }
            else {
                answer.0 = term
                answer.1 = true
            }
        }
        return answer
    }
}
