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
        let clueStart:Clue
        let clueEnd:Clue
    }
    
    var clues:[Clue] = []
    var lines:[Line] = []
    var crossingLines:[[Int]] = []
    
    func addClue(clue:Int, i:Int, j:Int) {
        clues.append(Clue(clue:clue, i:i, j:j))
    }
    
    func buildLines() {
        var grid:[[Clue?]] = Array.init(repeating: Array<Clue?>.init(repeating: nil, count: dim), count: dim)
        for clue in clues {
            grid[clue.i][clue.j] = clue
        }
        for clue in clues {
            // Is there a line to the right?
            var end = clue.j + 1
            var clueEnd:Clue? = nil
            while clueEnd == nil && end < dim {
                clueEnd = grid[clue.i][end]
                end = end + 1
            }
            if clueEnd != nil {
                addLine(clue, clueEnd!)
            }
            // Is the a line down?
            end = clue.i + 1
            clueEnd = nil
            while clueEnd == nil && end < dim {
                clueEnd = grid[end][clue.j]
                end = end + 1
            }
            if clueEnd != nil {
                addLine(clue, clueEnd!)
            }
        }
        buildCrossingLines()
    }
    
    private func buildCrossingLines() {
        for line in lines {
            var crosses:[Int] = []
            for i in 0..<lines.count {
                let other:Line = lines[i]
                if other.clueStart.i < line.clueEnd.i && line.clueStart.i < other.clueEnd.i &&
                    other.clueStart.j < line.clueEnd.j && line.clueStart.j < other.clueEnd.j {
                    crosses.append(i)
                }
            }
            crossingLines.append(crosses)
        }
    }
    
    private func addLine(_ clueStart:Clue, _ clueEnd:Clue) {
        lines.append(Line(clueStart: clueStart, clueEnd: clueEnd))
        clueStart.lines.append(lines.count - 1)
        clueEnd.lines.append(lines.count - 1)
    }
}
