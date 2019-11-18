//
//  KillerSudokuSolver.swift
//  My Extension
//
//  Created by mark on 11/15/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

class KillerSudokuSolver {
    let board:KillerSudokuBoard
    var solution:String
    let MAX = [0, 9, 17, 24, 30, 35, 39, 42, 44, 45]
    
    init(board:KillerSudokuBoard) {
        self.board = board
        self.solution = ""
    }
    
    func solve() -> Bool {
        var work = Array(repeating: 0, count: 81);
        if solveRecurse(work:&work) {
            for i in work {
                solution += String(i);
            }
            return true
        }
        return false
    }
    
    func solveRecurse(work:inout [Int]) -> Bool {
        for i in 0...80 {
            if (work[i] == 0) {
                for j in 1...9 {
                    if (isValid(work:work, at:i, value:j)) {
                        work[i] = j;
                        if (solveRecurse(work:&work)) {
                            return true;
                        }
                        work[i] = 0;
                    }
                }
                return false;
            }
        }
        return true;
    }
    
    func isValid(work:[Int], at:Int, value:Int) -> Bool {
        let row:Int = at / 9
        for i in 0...8 {
            if (work[9 * row + i] == value) {
                return false
            }
        }
        let col:Int = at % 9
        for i in 0...8 {
            if (work[9 * i + col]) == value {
                return false
            }
        }
        let rowBlock:Int = row / 3
        let colBlock:Int = col / 3
        let blockBase = rowBlock * 3 * 9 + colBlock * 3
        for i in 0...2 {
            for j in 0...2 {
                if (work[blockBase + 9 * i + j] == value) {
                    return false
                }
            }
        }
        let block = board.block(at:at);
        var sum = value
        var empty = -1
        for i in block.cells {
            if (work[i] == 0) {
                empty += 1
            }
            else {
                sum += work[i]
            }
        }
        if (0 == empty) {
            return sum == block.target
        }
        else if (block.target <= sum){
            return false;
        }
        else if (sum + MAX[empty] < block.target) {
            return false;
        }
        return true
    }
}
