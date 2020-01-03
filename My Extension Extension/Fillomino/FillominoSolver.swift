//
//  FillominoSolver.swift
//  My Extension Extension
//
//  Created by mark on 12/30/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class FillominoSolver {
    class State {
        var cells:[[Int?]]
        var cands:[[Set<Int>]]
        
        init(_ board:FillominoBoard) {
            let dim = board.clues.count
            cells = board.clues
            repeat {
                cands = Array.init(repeating: Array.init(repeating: Set<Int>(), count: dim), count:dim)
                buildCands()
            }
            while filterCands()
        }
        
        func check(_ i:Int, _ j:Int) -> Bool {
            if !checkCounts(i, j) {
                return false
            }
            if 0 < i && !checkNeighbor(i - 1, j, cells[i][j]!) {
                return false
            }
            if i < cells.count - 1 && !checkNeighbor(i + 1, j, cells[i][j]!) {
                return false
            }
            if 0 < j && !checkNeighbor(i, j - 1, cells[i][j]!) {
                return false
            }
            if j < cells[i].count - 1 && !checkNeighbor(i, j + 1, cells[i][j]!) {
                return false
            }
            return true
        }
        
        private func checkNeighbor(_ i:Int, _ j:Int, _ val:Int) -> Bool {
            return cells[i][j] == nil || cells[i][j] == val || checkCounts(i, j)
        }
        
        private func checkCounts(_ i:Int, _ j:Int) -> Bool {
            let clue = cells[i][j]!
            let (total, max, closed) = count(i, j)
            if clue < total {
                return false
            }
            if total < clue && closed {
                return false
            }
            if max < clue {
                return false
            }
            return true
        }
        
        private func count(_ i:Int, _ j:Int) -> (Int, Int, Bool) {
            let dim = cells.count
            let clue = cells[i][j]!
            var count = 0
            var max = 0
            var closed = true
            var reachable:[[Bool]] = Array.init(repeating: Array.init(repeating: false, count: dim), count: dim)
            var todo:[(Int, Int)] = [(i, j)]
            while 0 != todo.count {
                let pos = todo.removeLast()
                if reachable[pos.0][pos.1] {
                    continue
                }
                reachable[pos.0][pos.1] = true
                count = count + 1
                if 0 < pos.0 {
                    if cells[pos.0 - 1][pos.1] == nil {
                        closed = false
                    }
                    else if cells[pos.0 - 1][pos.1] == clue {
                        todo.append((pos.0 - 1, pos.1))
                    }
                }
                if pos.0 < dim - 1 {
                    if cells[pos.0 + 1][pos.1] == nil {
                        closed = false
                    }
                    else if cells[pos.0 + 1][pos.1] == clue {
                        todo.append((pos.0 + 1, pos.1))
                    }
                }
                if 0 < pos.1 {
                    if cells[pos.0][pos.1 - 1] == nil {
                        closed = false
                    }
                    else if cells[pos.0][pos.1 - 1] == clue {
                        todo.append((pos.0, pos.1 - 1))
                    }
                }
                if pos.1 < dim - 1 {
                    if cells[pos.0][pos.1 + 1] == nil {
                        closed = false
                    }
                    else if cells[pos.0][pos.1 + 1] == clue {
                        todo.append((pos.0, pos.1 + 1))
                    }
                }
            }
            reachable = Array.init(repeating: Array.init(repeating: false, count: dim), count: dim)
            todo = [(i, j)]
            while 0 != todo.count {
                let pos = todo.removeLast()
                if reachable[pos.0][pos.1] {
                    continue
                }
                reachable[pos.0][pos.1] = true
                max = max + 1
                if clue <= max {
                    break;
                }
                if 0 < pos.0 && (cells[pos.0 - 1][pos.1] == nil || cells[pos.0 - 1][pos.1] == clue) {
                    todo.append((pos.0 - 1, pos.1))
                }
                if pos.0 < dim - 1 && (cells[pos.0 + 1][pos.1] == nil || cells[pos.0 + 1][pos.1] == clue) {
                    todo.append((pos.0 + 1, pos.1))
                }
                if 0 < pos.1 && (cells[pos.0][pos.1 - 1] == nil || cells[pos.0][pos.1 - 1] == clue) {
                    todo.append((pos.0, pos.1 - 1))
                }
                if pos.1 < dim - 1 && (cells[pos.0][pos.1 + 1] == nil || cells[pos.0][pos.1 + 1] == clue) {
                    todo.append((pos.0, pos.1 + 1))
                }
            }
            return (count, max, closed)
        }
        
        private func buildCands() {
            for i in 0..<cells.count {
                for j in 0..<cells[i].count {
                    if nil != cells[i][j] {
                        let (total, _, _) = count(i, j)
                        if (total < cells[i][j]!) {
                            addCands(i, j, cells[i][j]!, total)
                        }
                    }
                }
            }
        }
        
        private func addCands(_ i:Int, _ j:Int, _ value:Int, _ dist:Int) {
            if value < dist {
                return
            }
            cands[i][j].insert(value)
            if 0 < i && nil == cells[i - 1][j] {
                addCands(i - 1, j, value, dist + 1)
            }
            if i < cells.count - 1 && nil == cells[i + 1][j] {
                addCands(i + 1, j, value, dist + 1)
            }
            if 0 < j && nil == cells[i][j - 1]{
                addCands(i, j - 1, value, dist + 1)
            }
            if j < cells[i].count - 1 && nil == cells[i][j + 1] {
                addCands(i, j + 1, value, dist + 1)
            }
        }
        
        private func filterCands() -> Bool {
            var didOne:Bool = true
            var answer:Bool = false
            while didOne {
                didOne = false
                for i in 0..<cells.count {
                    for j in 0..<cells[i].count {
                        if nil == cells[i][j] {
                            for value in cands[i][j] {
                                cells[i][j] = value
                                if !check(i, j) {
                                    cands[i][j].remove(value)
                                }
                            }
                            if cands[i][j].count == 1 {
                                cells[i][j] = cands[i][j].first!
                                didOne = true
                                answer = true
                            }
                            else {
                                cells[i][j] = nil
                            }
                        }
                    }
                }
            }
            return answer
        }
    }
    
    private let board:FillominoBoard
    
    init(_ board:FillominoBoard) {
        self.board = board
    }
    
    var solution:String = ""
    
    func solve() -> Bool {
        var state = State(board)
        if solveRecurse(&state) {
            for i in 0..<state.cells.count {
                for j in 0..<state.cells[i].count {
                    solution.append(Character(UnicodeScalar(state.cells[i][j]! + 48)!))
                }
            }
            return true
        }
        return false
    }
    
    private func solveRecurse(_ state:inout State) -> Bool {
        for i in 0..<state.cells.count {
            for j in 0..<state.cells[i].count {
                if nil != state.cells[i][j] {
                    continue
                }
                for val in state.cands[i][j] {
                    state.cells[i][j] = val
                    if !state.check(i, j) {
                        continue
                    }
                    if (solveRecurse(&state)) {
                        return true
                    }
                }
                state.cells[i][j] = nil
                return false
            }
        }
        return true
    }
}
