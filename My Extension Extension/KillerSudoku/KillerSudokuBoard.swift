//
//  KillerSudokuBoard.swift
//  My Extension
//
//  Created by mark on 11/15/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

class KillerSudokuBoard {
    class Block : Hashable {
        static func == (lhs: KillerSudokuBoard.Block, rhs: KillerSudokuBoard.Block) -> Bool {
            return lhs.target == rhs.target && lhs.cells == rhs.cells
        }
        
        init (target:Int, cells:[Int]) {
            self.target = target
            self.cells = cells
        }
        
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(target)
            hasher.combine(cells)
        }
        
        let target:Int
        let cells:[Int]
    }

    var blocks:[Block] = []
    private var blockIndex:[Block] = []
    
    init() {
    }
    
    func addBlock(block:Block) {
        blocks.append(block)
        blockIndex = []
    }
    
    func removeBlock(block:Block) {
        if let index = blocks.firstIndex(of: block) {
            blocks.remove(at: index)
            blockIndex = []
        }
    }
    
    func block(at:Int) -> Block {
        if (blockIndex.count == 0) {
            buildBlockIndex()
        }
        return blockIndex[at];
    }
    
    private func buildBlockIndex() {
        var temp:[Block?] = Array.init(repeating: nil, count: 81)
        for b in blocks {
            for c in b.cells {
                temp[c] = b
            }
        }
        for b in temp {
            blockIndex.append(b!)
        }
    }
}
