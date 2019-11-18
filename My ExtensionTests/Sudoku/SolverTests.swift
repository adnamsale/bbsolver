//
//  SolverTests.swift
//  My ExtensionTests
//
//  Created by mark on 11/14/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class SolverTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSolve() {
        let solver:SudokuSolver = SudokuSolver(board:"""
.5.....4.6.84.95.3.2.7.6.1..935.428...........452.816..3.6.1.9.2.69.53.1.1.....5.
""")
        XCTAssert(solver.solve())
        XCTAssertEqual("""
951382746678419523324756918193564287862197435745238169537621894286945371419873652
""", solver.solution)
    }
    
    func testSolveBad() {
        // Board is inconsistent, two 6s in top left square
        let solver:SudokuSolver = SudokuSolver(board:"""
.6.....4.6.84.95.3.2.7.6.1..935.428...........452.816..3.6.1.9.2.69.53.1.1.....5.
""")
        XCTAssertFalse(solver.solve())
    }
}
