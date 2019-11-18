//
//  Solver.swift
//  My Extension Extension
//
//  Created by mark on 11/13/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

class SudokuSolver {
    let board:String
    var solution:String
    
    init(board:String) {
        self.board = board
        self.solution = ""
    }
    
    func solve() -> Bool {
        var work = Array(repeating: 0, count: 81);
        var i = 0;
        for c in board {
            if (c != ".") {
                work[i] = Int(c.unicodeScalars.first!.value - Unicode.Scalar("0").value)
            }
            i += 1;
        }
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
        return true
    }
}
