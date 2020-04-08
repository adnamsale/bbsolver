//
//  NonogridsBoardParserTests.swift
//  My ExtensionTests
//
//  Created by mark on 3/28/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import XCTest

class NonogridsBoardParserTests: XCTestCase {
    func testReal() {
        let source = """
<tbody><tr><td></td><td class="t01" style="vertical-align: bottom; text-align: center;">3</td><td class="t00" style="vertical-align: bottom; text-align: center;">2</td><td class="t00" style="vertical-align: bottom; text-align: center;">2<br>2</td><td class="t00" style="vertical-align: bottom; text-align: center;">2</td><td class="t00" style="vertical-align: bottom; text-align: center;">1<br>1</td></tr><tr><td class="t10" style="vertical-align: middle; text-align: right;">&nbsp;3&nbsp;</td><td class="t11"><img id="square0" src="/gifs_nonogrids/n.gif"></td><td class="t10"><img id="square1" src="/gifs_nonogrids/n.gif"></td><td class="t10"><img id="square2" src="/gifs_nonogrids/n.gif"></td><td class="t10"><img id="square3" src="/gifs_nonogrids/n.gif"></td><td class="t10"><img id="square4" src="/gifs_nonogrids/n.gif"></td></tr><tr><td class="t00" style="vertical-align: middle; text-align: right;">&nbsp;2&nbsp;</td><td class="t01"><img id="square5" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square6" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square7" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square8" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square9" src="/gifs_nonogrids/n.gif"></td></tr><tr><td class="t00" style="vertical-align: middle; text-align: right;">&nbsp;1&nbsp;</td><td class="t01"><img id="square10" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square11" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square12" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square13" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square14" src="/gifs_nonogrids/n.gif"></td></tr><tr><td class="t00" style="vertical-align: middle; text-align: right;">&nbsp;3&nbsp;</td><td class="t01"><img id="square15" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square16" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square17" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square18" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square19" src="/gifs_nonogrids/n.gif"></td></tr><tr><td class="t00" style="vertical-align: middle; text-align: right;">&nbsp;3&nbsp;&nbsp;1&nbsp;</td><td class="t01"><img id="square20" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square21" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square22" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square23" src="/gifs_nonogrids/n.gif"></td><td class="t00"><img id="square24" src="/gifs_nonogrids/n.gif"></td></tr></tbody>
"""
        let parser = NonogridsBoardParser(source: source)
        let check = parser.parsed
        let solver = NonogridsSolver(check)
        XCTAssert(solver.solve())
    }
}
