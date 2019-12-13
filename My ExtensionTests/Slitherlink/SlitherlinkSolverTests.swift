//
//  SlitherlinkSolverTests.swift
//  My ExtensionTests
//
//  Created by mark on 12/12/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class SlitherlinkSolverTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMinimal() {
        let board = SlitherlinkBoard(clues:[4], dim:1)
        var solver = SlitherlinkSolver(board:board!)
        XCTAssert(solver.solve())
    }
    
    func testTwoByTwo() {
        let board = SlitherlinkBoard(clues:[2, nil, nil, nil], dim:2)
        var solver = SlitherlinkSolver(board:board!)
        XCTAssert(solver.solve())
    }
    
    func testAnotherTwoByTwo() {
        let board = SlitherlinkBoard(clues:[3, nil, nil, nil], dim:2)
        var solver = SlitherlinkSolver(board:board!)
        XCTAssert(solver.solve())
    }
    
    func testThreeByThree() {
        let board = SlitherlinkBoard(clues:[3, nil, nil, nil, nil, nil, 3, nil, nil], dim:3)
        var solver = SlitherlinkSolver(board:board!)
        XCTAssert(solver.solve())
    }
}
