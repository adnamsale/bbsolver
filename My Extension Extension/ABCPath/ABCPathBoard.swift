//
//  ABCPathBoard.swift
//  My Extension Extension
//
//  Created by mark on 12/18/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class ABCPathBoard {
    enum Direction {
        case HOR
        case VER
        case DIAG
    }
    
    struct Clue {
        let letter:Character
        let dir:Direction
        let index:Int
    }
    
    var clues:[Clue] = []
    var aPos:(Int, Int) = (0,0)
    
    func addClue(_ letter:Character, _ dir:Direction, _ index:Int) {
        clues.append(Clue(letter:letter, dir:dir, index:index))
    }
    
    func setAPos(_ row:Int, _ col:Int) {
        aPos = (row, col)
    }
}
