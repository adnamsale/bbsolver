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
    var auxBlocks:[KillerSudokuBoard.Block] = []
    var auxBlockIndex:[[KillerSudokuBoard.Block]] = []
    var candidates:[Set<Int>] = []
    
    init(board:KillerSudokuBoard) {
        self.board = board
        self.solution = ""
    }
    
    func solve() -> Bool {
        var work = Array(repeating: 0, count: 81);
        splitBlocks()
        buildCandidates()
        for i in 0...80 {
            if (candidates[i].count == 1) {
                work[i] = candidates[i].first!
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
                for j in candidates[i] {
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
        var used:[Bool] = Array.init(repeating: false, count: 9)
        
        for i in block.cells {
            if (work[i] == 0) {
                empty += 1
            }
            else {
                if (used[work[i] - 1]) {
                    return false
                }
                used[work[i] - 1] = true
                sum += work[i]
            }
        }
        if (0 == empty) {
            if (sum != block.target) {
                return false
            }
        }
        else if (block.target <= sum){
            return false;
        }
        else if (sum + MAX[empty] < block.target) {
            return false;
        }
        for b in auxBlockIndex[at] {
            var sum = value
            var empty = -1
            
            for c in b.cells {
                if (work[c] == 0) {
                    empty += 1
                }
                else {
                    sum += work[c]
                }
            }
            if (0 == empty) {
                if (sum != b.target) {
                    return false
                }
            }
            else if (b.target <= sum){
                return false;
            }
            else if (sum + 9 * empty < b.target) {
                return false;
            }
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
        // If the remaining cells don't belong to a single block then we can create an 'auxiliary'
        // block for them since we know their total. Aux blocks can be useful for testing whether
        // positions are valid.
        while (splitBlocksRecurse()) {
        }
        createAuxBlockIndex()
    }
    
    func splitBlocksRecurse() -> Bool {
        for i in 1...8 {
            for base in stride(from:0, to:81 - 9 * i, by:9) {
                let row = [Int](base...base + 9 * i - 1)
                if (splitBlocks(row)) {
                    return true
                }
            }
        }
        var cols:[[Int]] = []
        for i in 0...8 {
            cols.append([Int](stride(from: i, to:81, by:9)))
        }
        for base in 0...8 {
            var set:[Int] = []
            for i in 1...min(8, 9 - base) {
                set = set + cols[base + i - 1]
                if (splitBlocks(set)) {
                    return true
                }
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
        for b in auxBlocks {
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
        if (1 < remaining.count) {
            return auxSplitBlocks(work, target)
        }
        else if (0 == remaining.count) {
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
    
    private func auxSplitBlocks(_ work:Set<Int>, _ target:Int) -> Bool {
        let newBlock:KillerSudokuBoard.Block = KillerSudokuBoard.Block(target:target, cells:Array(work))
        if (auxBlocks.contains(newBlock)) {
            return false
        }
        auxBlocks.append(newBlock)
        return true
    }
    
    private func createAuxBlockIndex() {
        auxBlockIndex = Array.init(repeating: [], count: 81)
        for b in auxBlocks {
            for c in b.cells {
                auxBlockIndex[c].append(b)
            }
        }
    }
    
    private func buildCandidates() {
        candidates = Array.init(repeating: Set(1...9), count: 81)
        for b in board.blocks {
            if b.cells.count == 1 {
                candidates[b.cells[0]] = Set([b.target])
            }
        }
        var recheck:Bool = true
        while (recheck) {
            recheck = false
            for b in board.blocks {
                if b.cells.count == 2 {
                    for i in candidates[b.cells[0]] {
                        if (!candidates[b.cells[1]].contains(b.target - i) || (b.target - i == i)) {
                            recheck = true
                            candidates[b.cells[0]].remove(i)
                        }
                    }
                    for i in candidates[b.cells[1]] {
                        if (!candidates[b.cells[0]].contains(b.target - i)) {
                            recheck = true
                            candidates[b.cells[1]].remove(i)
                        }
                    }
                }
            }
            for b in auxBlocks {
                if b.cells.count == 2 {
                    for i in candidates[b.cells[0]] {
                        if (!candidates[b.cells[1]].contains(b.target - i)) {
                            recheck = true
                            candidates[b.cells[0]].remove(i)
                        }
                    }
                    for i in candidates[b.cells[1]] {
                        if (!candidates[b.cells[0]].contains(b.target - i)) {
                            recheck = true
                            candidates[b.cells[1]].remove(i)
                        }
                    }
                }
            }
        }
    }
}
