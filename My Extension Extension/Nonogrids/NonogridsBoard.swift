//
//  NonogridsBoard.swift
//  My Extension Extension
//
//  Created by mark on 3/28/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class NonogridsBoard {
    private var across:[[Int]]
    private var down:[[Int]]
    
    init() {
        across = []
        down = []
    }
    
    func addAcross(_ clue:[Int]) {
        across.append(clue)
    }
    
    func addDown(_ clue:[Int]) {
        down.append(clue)
    }
    
    func getAcross(_ i:Int) -> [Int] {
        return across[i]
    }
    
    func getDown(_ i:Int) -> [Int] {
        return down[i]
    }

    var dim:Int {
        get {
            return across.count
        }
    }
}
