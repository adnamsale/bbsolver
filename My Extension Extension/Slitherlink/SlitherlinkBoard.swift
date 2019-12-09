//
//  SlitherlinkBoard.swift
//  My Extension Extension
//
//  Created by mark on 11/26/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class SlitherlinkBoard {
    private let clues:[Int?]
    let dim:Int
    
    init!(clues:[Int?], dim:Int) {
        if (clues.count != dim * dim) {
            return nil;
        }
        self.clues = clues
        self.dim = dim
    }
    
    func clue(_ i:Int, _ j:Int) -> Int? {
        return clues[i * dim + j];
    }
}
