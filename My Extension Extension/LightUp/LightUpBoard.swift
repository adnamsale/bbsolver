//
//  LightUpBoard.swift
//  My Extension Extension
//
//  Created by mark on 1/16/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class LightUpBoard {
    let clues:[[Int?]]
    
    init(_ clues:[[Int?]]) {
        self.clues = clues
    }
    
    func getClue(_ i:Int, _ j:Int) -> Int? {
        if 0 <= i && i < clues.count && 0 <= j && j < clues[i].count && nil != clues[i][j] && 9 != clues[i][j] {
            return clues[i][j]
        }
        return nil
    }
    
    func isBlock(_ i:Int, _ j:Int) -> Bool {
        if i < 0 || clues.count <= i || j < 0 || clues[i].count <= j {
            return true
        }
        return nil != clues[i][j]
    }
}
