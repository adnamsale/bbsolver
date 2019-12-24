//
//  BridgesBoard.swift
//  My Extension Extension
//
//  Created by mark on 12/23/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class BridgesBoard {
    var dim:Int = 0
    
    class Clue {
        let clue:Int
        let i:Int
        let j:Int
        var lines:[Int]
        
        init(clue:Int, i:Int, j:Int) {
            self.clue = clue
            self.i = i
            self.j = j
            self.lines = []
        }
    }
    
    struct Line {
        let clueStart:Int
        let clueEnd:Int
    }
    
    var clues:[Clue] = []
    var lines:[Line] = []
    var crossingLines:[[Int]] = []
    
    func addClue(clue:Int, i:Int, j:Int) {
        clues.append(Clue(clue:clue, i:i, j:j))
    }
    
    func buildLines() {
        var grid:[[Int?]] = Array.init(repeating: Array<Int?>.init(repeating: nil, count: dim), count: dim)
        for i in 0..<clues.count {
            grid[clues[i].i][clues[i].j] = i
        }
        for i in 0..<clues.count {
            // Is there a line to the right?
            let clue = clues[i]
            var end = clue.j + 1
            var clueEnd:Int? = nil
            while clueEnd == nil && end < dim {
                clueEnd = grid[clue.i][end]
                end = end + 1
            }
            if clueEnd != nil {
                addLine(i, clueEnd!)
            }
            // Is the a line down?
            end = clue.i + 1
            clueEnd = nil
            while clueEnd == nil && end < dim {
                clueEnd = grid[end][clue.j]
                end = end + 1
            }
            if clueEnd != nil {
                addLine(i, clueEnd!)
            }
        }
        buildCrossingLines()
    }
    
    private func buildCrossingLines() {
        for line in lines {
            var crosses:[Int] = []
            for i in 0..<lines.count {
                let other:Line = lines[i]
                if clues[other.clueStart].i < clues[line.clueEnd].i &&
                        clues[line.clueStart].i < clues[other.clueEnd].i &&
                        clues[other.clueStart].j < clues[line.clueEnd].j &&
                        clues[line.clueStart].j < clues[other.clueEnd].j {
                    crosses.append(i)
                }
            }
            crossingLines.append(crosses)
        }
    }
    
    private func addLine(_ clueStart:Int, _ clueEnd:Int) {
        lines.append(Line(clueStart: clueStart, clueEnd: clueEnd))
        clues[clueStart].lines.append(lines.count - 1)
        clues[clueEnd].lines.append(lines.count - 1)
    }
}
