//
//  ABCPathSolver.swift
//  My Extension Extension
//
//  Created by mark on 12/18/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class ABCPathState {
    private struct LetterSet: OptionSet {
        let rawValue:Int
    }
    
    private var grid:[[Set<Int>]]
    
    init(_ board:ABCPathBoard) {
        grid = Array.init(repeating: Array.init(repeating: Set<Int>(), count: 5), count: 5)
        for clue in board.clues {
            var xStart = 0
            var yStart = 0
            var xDelta = 0
            var yDelta = 0
            switch (clue.dir) {
            case ABCPathBoard.Direction.DIAG:
                if clue.index == 0 {
                    xDelta = 1
                    yDelta = 1
                }
                else {
                    yStart = 4
                    xDelta = 1
                    yDelta = -1
                }
                break
            case ABCPathBoard.Direction.HOR:
                yDelta = 1
                xStart = clue.index
                break
            case ABCPathBoard.Direction.VER:
                xDelta = 1
                yStart = clue.index
                break
            }
            for _ in 0..<5 {
                grid[xStart][yStart].insert(Int(clue.letter.asciiValue! - 65))
                xStart += xDelta
                yStart += yDelta
            }
            let (aRow, aCol) = board.aPos
            grid[aRow][aCol] = Set<Int>([0])
        }
    }
    
    func isSet(_ i:Int, _ j:Int, _ letter:Int) -> Bool {
        if (0 <= i && i < 5 && 0 <= j && j < 5) {
            return grid[i][j].contains(letter)
        }
        return false
    }
    
    func remove(_ i:Int, _ j:Int, _ letter:Int) {
        grid[i][j].remove(letter)
    }
    
    func isSolved() -> Bool {
        for i in 0..<5 {
            for j in 0..<5 {
                if grid[i][j].count != 1 {
                    return false
                }
            }
        }
        return true
    }
    
    func cell(_ i:Int, _ j:Int) -> Set<Int> {
        return grid[i][j]
    }
    
    func isAdjacent(_ i:Int, _ j:Int, _ letter:Int) -> Bool {
        return isSet(i - 1, j, letter) || isSet(i + 1, j , letter) ||
            isSet(i, j - 1, letter) || isSet(i, j + 1, letter) ||
            isSet(i - 1, j - 1, letter) || isSet(i - 1, j + 1, letter) ||
            isSet(i + 1, j - 1, letter) || isSet(i + 1, j + 1, letter)
    }
        
    func set(_ i:Int, _ j:Int, _ letter:Int) {
            grid[i][j] = Set<Int>([letter])
    }
    
    func restore(_ i:Int, _ j:Int, _ set:Set<Int>) {
        grid[i][j] = set
    }
}

class ABCPathSolver {
    let board:ABCPathBoard
    var solution:String
    
    init(_ board:ABCPathBoard) {
        self.board = board
        solution = ""
    }

    func solve() -> Bool {
        var state = ABCPathState(board)
        var didOne = true
        while didOne {
            didOne = false
            for i in 0..<5 {
                for j in 0..<5 {
                    for letter in state.cell(i, j) {
                        if (0 == letter) {
                            continue
                        }
                        if !state.isAdjacent(i, j, letter - 1) {
                            didOne = true
                            state.remove(i, j, letter)
                        }
                        else if letter < 24 && !state.isAdjacent(i, j, letter + 1) {
                            didOne = true
                            state.remove(i, j, letter)
                        }
                    }
                    if (state.cell(i, j).isEmpty) {
                        return false
                    }
                }
            }
        }
        if !state.isSolved() {
            var used:Dictionary<Int, (Int,Int)> = [:]
            for i in 0..<5 {
                for j in 0..<5 {
                    if (state.cell(i, j).count == 1) {
                        used[state.cell(i, j).first!] = (i, j)
                    }
                }
            }
            if !solveRecurse(&state, &used) {
                return false
            }
        }
        for i in 0..<5 {
            for j in 0..<5 {
                solution.append(Character(UnicodeScalar(state.cell(i, j).first! + 65)!))
            }
        }
        return true
    }
    
    private func solveRecurse(_ state:inout ABCPathState, _ used:inout Dictionary<Int, (Int, Int)>) -> Bool {
        for i in 0..<5 {
            for j in 0..<5 {
                if state.cell(i, j).count != 1 {
                    let safe = state.cell(i, j)
                    for letter in safe {
                        if used[letter] != nil {
                            continue
                        }
                        if let prevPos = used[letter - 1] {
                            if 1 < abs(prevPos.0 - i) || 1 < abs(prevPos.1 - j) {
                                continue
                            }
                        }
                        else {
                            if !state.isAdjacent(i, j, letter - 1) {
                                continue
                            }
                        }
                        if let nextPos = used[letter + 1] {
                            if 1 < abs(nextPos.0 - i) || 1 < abs(nextPos.1 - j) {
                                continue
                            }
                        }
                        state.set(i, j, letter)
                        used[letter] = (i, j)
                        let answer = solveRecurse(&state, &used)
                        if answer {
                            return true
                        }
                        used.removeValue(forKey: letter)
                    }
                    state.restore(i, j, safe)
                    return false
                }
            }
        }
        return true
    }
}
