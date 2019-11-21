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
    let MIN = [0, 1,  3,  6, 10, 15, 21, 28, 36, 45]
    
    init(board:KillerSudokuBoard) {
        self.board = board
        self.solution = ""
    }
    
    func solve() -> Bool {
        var work = Array(repeating: 0, count: 81);
        splitBlocks()
        for b in board.blocks {
            if (b.cells.count == 1) {
                work[b.cells[0]] = b.target
            }
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
    func splitBlocks() {
        // For any group of cells with a known total (row, column, square or multiples thereof)
        // we can try to remove all blocks wholly contained in that group. If the remaining cells
        // belong to a single block then we know the subtotal for those cells so we can split the
        // block into two smaller blocks, one inside the group and one outside. In the best case,
        // one or other block will be a single cell and we will have fixed its value. In any case
        // smaller blocks are more efficient since they have fewer options to search.
        while (splitBlocksRecurse()) {
        }
    }
    
    func splitBlocksRecurse() -> Bool {
        for i in 1...4 {
            for base in stride(from:0, to:81 - 9 * i, by:9) {
                let row = [Int](base...base + 9 * i - 1)
                if (splitBlocks(row)) {
                    return true
                }
            }
        }
        for i in 0...8 {
            let col = [Int](stride(from: i, to:81, by:9))
            if splitBlocks(col) {
                return true
            }
        }
        for i in 0...2 {
            for j in 0...2 {
                let base = 27 * i + 3 * j
                let square = [base, base + 1, base + 2, base + 9, base + 10, base + 11, base + 18, base + 19, base + 20]
                if splitBlocks(square) {
                    return true
                }
            }
        }
        return false
    }
    
    func splitBlocks(_ set:[Int]) -> Bool {
        var work = Set(set)
        var target = set.count * 5
        for b in board.blocks {
            if (work.isSuperset(of: b.cells)) {
                for c in b.cells {
                    work.remove(c)
                }
                target -= b.target
            }
        }
        var remaining = Set<KillerSudokuBoard.Block>()
        for i in work {
            remaining.insert(board.block(at: i))
        }
        if (remaining.count != 1) {
            return false
        }
        let oldBlock  = remaining.first!
        let newBlock1 = KillerSudokuBoard.Block(target: target, cells: Array(work))
        var newBlock2Cells:[Int] = []
        for c in oldBlock.cells {
            if (!(work.contains(c))) {
                newBlock2Cells.append(c)
            }
        }
        let newBlock2 = KillerSudokuBoard.Block(target: oldBlock.target - target, cells: newBlock2Cells)
        board.addBlock(block: newBlock1)
        board.addBlock(block: newBlock2)
        board.removeBlock(block: oldBlock)
        return true
    }
}
