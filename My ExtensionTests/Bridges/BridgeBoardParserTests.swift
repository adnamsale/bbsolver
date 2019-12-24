//
//  BridgeBoardParserTests.swift
//  My ExtensionTests
//
//  Created by mark on 12/23/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class BridgeBoardParserTests: XCTestCase {
    func testReal() {
            let source = """
<tbody><tr><td class="bridgetd"><img id="square0" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square1" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square2" src="/gifs_bridges_new/2w.gif"></td><td class="bridgetd"><img id="square3" src="/gifs_bridges_new/=.gif"></td><td class="bridgetd"><img id="square4" src="/gifs_bridges_new/3w.gif"></td><td class="bridgetd"><img id="square5" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square6" src="/gifs_bridges_new/1w.gif"></td></tr><tr><td class="bridgetd"><img id="square7" src="/gifs_bridges_new/4w.gif"></td><td class="bridgetd"><img id="square8" src="/gifs_bridges_new/=.gif"></td><td class="bridgetd"><img id="square9" src="/gifs_bridges_new/=.gif"></td><td class="bridgetd"><img id="square10" src="/gifs_bridges_new/3w.gif"></td><td class="bridgetd"><img id="square11" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square12" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square13" src="/gifs_bridges_new/x.gif"></td></tr><tr><td class="bridgetd"><img id="square14" src="/gifs_bridges_new/n.gif"></td><td class="bridgetd"><img id="square15" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square16" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square17" src="/gifs_bridges_new/i.gif"></td><td class="bridgetd"><img id="square18" src="/gifs_bridges_new/3w.gif"></td><td class="bridgetd"><img id="square19" src="/gifs_bridges_new/=.gif"></td><td class="bridgetd"><img id="square20" src="/gifs_bridges_new/4w.gif"></td></tr><tr><td class="bridgetd"><img id="square21" src="/gifs_bridges_new/3w.gif"></td><td class="bridgetd"><img id="square22" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square23" src="/gifs_bridges_new/1w.gif"></td><td class="bridgetd"><img id="square24" src="/gifs_bridges_new/i.gif"></td><td class="bridgetd"><img id="square25" src="/gifs_bridges_new/i.gif"></td><td class="bridgetd"><img id="square26" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square27" src="/gifs_bridges_new/n.gif"></td></tr><tr><td class="bridgetd"><img id="square28" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square29" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square30" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square31" src="/gifs_bridges_new/i.gif"></td><td class="bridgetd"><img id="square32" src="/gifs_bridges_new/1w.gif"></td><td class="bridgetd"><img id="square33" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square34" src="/gifs_bridges_new/n.gif"></td></tr><tr><td class="bridgetd"><img id="square35" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square36" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square37" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square38" src="/gifs_bridges_new/i.gif"></td><td class="bridgetd"><img id="square39" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square40" src="/gifs_bridges_new/x.gif"></td><td class="bridgetd"><img id="square41" src="/gifs_bridges_new/n.gif"></td></tr><tr><td class="bridgetd"><img id="square42" src="/gifs_bridges_new/1w.gif"></td><td class="bridgetd"><img id="square43" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square44" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square45" src="/gifs_bridges_new/3w.gif"></td><td class="bridgetd"><img id="square46" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square47" src="/gifs_bridges_new/-.gif"></td><td class="bridgetd"><img id="square48" src="/gifs_bridges_new/3w.gif"></td></tr></tbody>
"""
        let parser = BridgesBoardParser(source: source);
        let check = parser.parsed;
        let solver = BridgesSolver(check)
        XCTAssert(solver.solve())
    }
}
