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
        
        init(_ board:FillominoBoard) {
            cells = board.clues
        }
        
        func neighbors(_ i:Int, _ j:Int) -> Set<Int?> {
            var answer:Set<Int?> = Set<Int?>()
            if 0 < i {
                answer.insert(cells[i - 1][j])
            }
            if i < cells.count - 1 {
                answer.insert(cells[i + 1][j])
            }
            if 0 < j {
                answer.insert(cells[i][j - 1])
            }
            if j < cells[i].count - 1 {
                answer.insert(cells[i][j + 1])
            }
            return answer
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
            let (total, closed) = count(i, j)
            if clue < total {
                return false
            }
            if total < clue && closed {
                return false
            }
            return true
        }
        
        func count(_ i:Int, _ j:Int) -> (Int, Bool) {
            let dim = cells.count
            let clue = cells[i][j]
            var count = 0
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
            return (count, closed)
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
                var neighbors:Set<Int?> = state.neighbors(i, j)
                fixNeighbors(&neighbors)
                for val in neighbors {
                    state.cells[i][j] = val!
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
    
    private func fixNeighbors(_ neighbors:inout Set<Int?>) {
        if neighbors.contains(1) {
            neighbors.remove(1)
        }
        if neighbors.contains(nil) {
            neighbors.remove(nil)
            for i in 3...9 {
                neighbors.insert(i)
            }
        }
    }
}
