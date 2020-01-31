//
//  LightUpSolver.swift
//  My Extension Extension
//
//  Created by mark on 1/16/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class LightUpSolver {
    class State {
        var cells:[[Bool?]]
        var coverCounts:[[Int]]

        init(_ board:LightUpBoard) {
            let dim = board.clues.count
            cells = Array.init(repeating: Array.init(repeating:nil, count: dim),count:dim)
            coverCounts = Array.init(repeating: Array.init(repeating:0, count: dim),count:dim)
        }
    }
    
    private let board:LightUpBoard;
    
    init(_ board:LightUpBoard) {
        self.board = board
    }
    
    var solution:String = ""

    func solve() -> Bool {
        var state = State(board)
        setStartingMoves(&state)
        
        if solveRecurse(&state) {
            for i in 0..<state.cells.count {
                for j in 0..<state.cells[i].count {
                    if nil != board.clues[i][j] {
                        solution.append(" ")
                    }
                    else if true == state.cells[i][j] {
                        solution.append("B")
                    }
                    else if false == state.cells[i][j] {
                        solution.append("X")
                    }
                    else {
                        solution.append("C")
                    }
                }
            }
            return true
        }
        return false
    }
    
    func solveRecurse(_ state:inout State) -> Bool {
        for i in 0..<board.clues.count {
            for j in 0..<board.clues[i].count {
                if board.clues[i][j] != nil || state.cells[i][j] != nil || state.coverCounts[i][j] != 0 {
                    continue
                }
                state.cells[i][j] = true
                updateCoverCounts(&state, i, j, 1)
                if isMoveValid(&state, i, j) && solveRecurse(&state) {
                    return true
                }
                updateCoverCounts(&state, i, j, -1)
                state.cells[i][j] = false
                if isMoveValid(&state, i, j) && solveRecurse(&state) {
                    return true
                }
                state.cells[i][j] = nil
                return false
            }
        }
        for i in 0..<board.clues.count {
            for j in 0..<board.clues[i].count {
                if board.clues[i][j] == nil && state.cells[i][j] != true && state.coverCounts[i][j] == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    private func setStartingMoves(_ state:inout State) {
        var didOne:Bool = true
        while didOne {
            didOne = false
            for i in 0..<board.clues.count {
                for j in 0..<board.clues[i].count {
                    if let clue = board.getClue(i, j) {
                        let (b, w) = getCounts(state, i, j)
                        if w == 4 - clue && clue != b {
                            didOne = true
                            setIfEmpty(&state, i - 1, j, true)
                            setIfEmpty(&state, i + 1, j, true)
                            setIfEmpty(&state, i, j - 1, true)
                            setIfEmpty(&state, i, j + 1, true)
                        }
                        if b == clue && w != 4 - clue {
                            didOne = true
                            setIfEmpty(&state, i - 1, j, false)
                            setIfEmpty(&state, i + 1, j, false)
                            setIfEmpty(&state, i, j - 1, false)
                            setIfEmpty(&state, i, j + 1, false)
                        }
                    }
                    if !board.isBlock(i, j) && state.cells[i][j] != true && 0 == state.coverCounts[i][j] {
                        if let (ci, cj) = findSingleCover(state, i, j) {
                            didOne = true
                            state.cells[ci][cj] = true
                            updateCoverCounts(&state, ci, cj, 1)
                        }
                    }
                }
            }
        }
    }
    
    private func findSingleCover(_ state:State, _ i:Int, _ j:Int) -> (Int, Int)? {
        var answer:(Int, Int)? = nil;
        if state.cells[i][j] == nil {
            answer = (i,j)
        }
        var x = i - 1
        var y = j
        while !board.isBlock(x, y) {
            if state.cells[x][y] == nil && 0 == state.coverCounts[x][y] {
                if nil == answer {
                    answer = (x, y)
                }
                else {
                    return nil;
                }
            }
            x = x - 1
        }
        x = i + 1
        while !board.isBlock(x, y) {
            if state.cells[x][y] == nil && 0 == state.coverCounts[x][y] {
                if nil == answer {
                    answer = (x, y)
                }
                else {
                    return nil;
                }
            }
            x = x + 1
        }
        x = i
        y = j - 1
        while !board.isBlock(x, y) {
            if state.cells[x][y] == nil && 0 == state.coverCounts[x][y] {
                if nil == answer {
                    answer = (x, y)
                }
                else {
                    return nil;
                }
            }
            y = y - 1
        }
        y = j + 1
        while !board.isBlock(x, y) {
            if state.cells[x][y] == nil && 0 == state.coverCounts[x][y] {
                if nil == answer {
                    answer = (x, y)
                }
                else {
                    return nil;
                }
            }
            y = y + 1
        }
        return answer
    }
    
    private func setIfEmpty(_ state:inout State, _ i:Int, _ j:Int, _ value:Bool) {
        guard 0 <= i && i < board.clues.count && 0 <= j && j < board.clues[i].count else {
            return
        }
        guard board.clues[i][j] == nil && state.cells[i][j] == nil && 0 == state.coverCounts[i][j] else {
            return
        }
        state.cells[i][j] = value
        if value {
            updateCoverCounts(&state, i, j, 1)
        }
    }
    
    private func isMoveValid(_ state:inout State, _ i:Int, _ j:Int) -> Bool {
        if !verifyCell(state, i, j) {
            return false
        }
        else if state.cells[i][j] == true {
            if !verifyCells(state, i, j) {
                return false
            }
        }
        return true
    }
    
    private func verifyCell(_ state:State, _ i:Int, _ j:Int) -> Bool {
        return verifyClue(state, i - 1, j) && verifyClue(state, i + 1, j) && verifyClue(state, i, j - 1) && verifyClue(state, i, j + 1)
    }
    
    private func updateCoverCounts(_ state:inout State, _ i:Int, _ j:Int, _ delta:Int) {
        var x = i - 1
        var y = j
        while !board.isBlock(x, y) {
            state.coverCounts[x][y] = state.coverCounts[x][y] + delta
            x = x - 1
        }
        x = i + 1
        while !board.isBlock(x, y) {
            state.coverCounts[x][y] = state.coverCounts[x][y] + delta
            x = x + 1
        }
        x = i
        y = j - 1
        while !board.isBlock(x, y) {
            state.coverCounts[x][y] = state.coverCounts[x][y] + delta
            y = y - 1
        }
        y = j + 1
        while !board.isBlock(x, y) {
            state.coverCounts[x][y] = state.coverCounts[x][y] + delta
            y = y + 1
        }
    }
    
    private func verifyCells(_ state:State, _ i:Int, _ j:Int) -> Bool {
        var x = i - 1
        var y = j
        while !board.isBlock(x, y) {
            if !verifyCell(state, x, y) {
                return false
            }
            x = x - 1
        }
        x = i + 1
        while !board.isBlock(x, y) {
            if !verifyCell(state, x, y) {
                return false
            }
            x = x + 1
        }
        x = i
        y = j - 1
        while !board.isBlock(x, y) {
            if !verifyCell(state, x, y) {
                return false
            }
            y = y - 1
        }
        y = j + 1
        while !board.isBlock(x, y) {
            if !verifyCell(state, x, y) {
                return false
            }
            y = y + 1
        }
        return true
    }
    
    private func verifyClue(_ state:State, _ i:Int, _ j:Int) -> Bool {
        guard let clue = board.getClue(i, j) else {
            return true
        }
        let (b, w) = getCounts(state, i, j)
        return b <= clue && w <= 4 - clue
    }
    
    private func getCounts(_ state:State, _ i:Int, _ j:Int) -> (Int, Int) {
        var b = 0
        var w = 0
        if 0 < i {
            if state.cells[i - 1][j] == true {
                b = b + 1
            }
            else if state.cells[i - 1][j] == false || 0 != state.coverCounts[i - 1][j] || board.clues[i - 1][j] != nil {
                w = w + 1
            }
        }
        else {
            w = w + 1
        }
        if i < state.cells.count - 1 {
            if state.cells[i + 1][j] == true {
                b = b + 1
            }
            else if state.cells[i + 1][j] == false || 0 != state.coverCounts[i + 1][j] || board.clues[i + 1][j] != nil {
                w = w + 1
            }
        }
        else {
            w = w + 1
        }
        if 0 < j {
            if state.cells[i][j - 1] == true {
                b = b + 1
            }
            else if state.cells[i][j - 1] == false || 0 != state.coverCounts[i][j - 1] || board.clues[i][j - 1] != nil {
                w = w + 1
            }
        }
        else {
            w = w + 1
        }
        if j < state.cells[i].count - 1 {
            if state.cells[i][j + 1] == true {
                b = b + 1
            }
            else if state.cells[i][j + 1] == false || 0 != state.coverCounts[i][j + 1] || board.clues[i][j + 1] != nil {
                w = w + 1
            }
        }
        else {
            w = w + 1
        }
        return (b,w)
    }
}
