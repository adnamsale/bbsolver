//
//  LightUpBoardParserTests.swift
//  My ExtensionTests
//
//  Created by mark on 1/29/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class LightUpBoardParserTests: XCTestCase {
    func testReal() {
        let source = """
<tbody><tr><td class="lightup"><img id="square0" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square1" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square2" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square3" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square4" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square5" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square6" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square7" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square8" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square9" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square10" src="/gifs_lightup/clue3.gif"></td><td class="lightup"><img id="square11" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square12" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square13" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square14" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square15" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square16" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square17" src="/gifs_lightup/clue0.gif"></td><td class="lightup"><img id="square18" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square19" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square20" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square21" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square22" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square23" src="/gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square24" src="/gifs_lightup/whte.gif"></td></tr></tbody>
"""
        let parser = LightUpBoardParser(source: source);
        let check = parser.parsed;
        let solver = LightUpSolver(check)
        XCTAssert(solver.solve())
    }
    
    func testReal2() {
        let source = """
<tbody><tr><td class="lightup"><img id="square0" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square1" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square2" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square3" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square4" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square5" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square6" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square7" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square8" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square9" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square10" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square11" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square12" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square13" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square14" src="gifs_lightup/yell.gif"></td></tr><tr><td class="lightup"><img id="square15" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square16" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square17" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square18" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square19" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square20" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square21" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square22" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square23" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square24" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square25" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square26" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square27" src="gifs_lightup/clud2.gif"></td><td class="lightup"><img id="square28" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square29" src="/gifs_lightup/clueB.gif"></td></tr><tr><td class="lightup"><img id="square30" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square31" src="gifs_lightup/clue2.gif"></td><td class="lightup"><img id="square32" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square33" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square34" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square35" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square36" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square37" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square38" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square39" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square40" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square41" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square42" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square43" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square44" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square45" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square46" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square47" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square48" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square49" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square50" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square51" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square52" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square53" src="gifs_lightup/clue2.gif"></td><td class="lightup"><img id="square54" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square55" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square56" src="gifs_lightup/clud2.gif"></td><td class="lightup"><img id="square57" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square58" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square59" src="/gifs_lightup/clueB.gif"></td></tr><tr><td class="lightup"><img id="square60" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square61" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square62" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square63" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square64" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square65" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square66" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square67" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square68" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square69" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square70" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square71" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square72" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square73" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square74" src="gifs_lightup/yell.gif"></td></tr><tr><td class="lightup"><img id="square75" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square76" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square77" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square78" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square79" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square80" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square81" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square82" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square83" src="gifs_lightup/clue2.gif"></td><td class="lightup"><img id="square84" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square85" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square86" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square87" src="gifs_lightup/clud1.gif"></td><td class="lightup"><img id="square88" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square89" src="gifs_lightup/yell.gif"></td></tr><tr><td class="lightup"><img id="square90" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square91" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square92" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square93" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square94" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square95" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square96" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square97" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square98" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square99" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square100" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square101" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square102" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square103" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square104" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square105" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square106" src="gifs_lightup/clud3.gif"></td><td class="lightup"><img id="square107" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square108" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square109" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square110" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square111" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square112" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square113" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square114" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square115" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square116" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square117" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square118" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square119" src="gifs_lightup/crss.gif"></td></tr><tr><td class="lightup"><img id="square120" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square121" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square122" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square123" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square124" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square125" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square126" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square127" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square128" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square129" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square130" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square131" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square132" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square133" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square134" src="gifs_lightup/clud0.gif"></td></tr><tr><td class="lightup"><img id="square135" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square136" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square137" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square138" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square139" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square140" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square141" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square142" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square143" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square144" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square145" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square146" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square147" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square148" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square149" src="gifs_lightup/crsy.gif"></td></tr><tr><td class="lightup"><img id="square150" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square151" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square152" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square153" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square154" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square155" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square156" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square157" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square158" src="gifs_lightup/clud2.gif"></td><td class="lightup"><img id="square159" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square160" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square161" src="gifs_lightup/clud1.gif"></td><td class="lightup"><img id="square162" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square163" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square164" src="gifs_lightup/crss.gif"></td></tr><tr><td class="lightup"><img id="square165" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square166" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square167" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square168" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square169" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square170" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square171" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square172" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square173" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square174" src="gifs_lightup/crsy.gif"></td><td class="lightup"><img id="square175" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square176" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square177" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square178" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square179" src="gifs_lightup/yell.gif"></td></tr><tr><td class="lightup"><img id="square180" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square181" src="gifs_lightup/clud1.gif"></td><td class="lightup"><img id="square182" src="gifs_lightup/clud1.gif"></td><td class="lightup"><img id="square183" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square184" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square185" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square186" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square187" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square188" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square189" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square190" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square191" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square192" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square193" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square194" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square195" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square196" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square197" src="gifs_lightup/bulb.gif"></td><td class="lightup"><img id="square198" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square199" src="gifs_lightup/clue1.gif"></td><td class="lightup"><img id="square200" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square201" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square202" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square203" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square204" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square205" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square206" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square207" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square208" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square209" src="/gifs_lightup/whte.gif"></td></tr><tr><td class="lightup"><img id="square210" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square211" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square212" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square213" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square214" src="/gifs_lightup/clueB.gif"></td><td class="lightup"><img id="square215" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square216" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square217" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square218" src="gifs_lightup/yell.gif"></td><td class="lightup"><img id="square219" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square220" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square221" src="gifs_lightup/clud0.gif"></td><td class="lightup"><img id="square222" src="gifs_lightup/crss.gif"></td><td class="lightup"><img id="square223" src="/gifs_lightup/whte.gif"></td><td class="lightup"><img id="square224" src="gifs_lightup/clue1.gif"></td></tr></tbody>
"""
        let parser = LightUpBoardParser(source: source);
        let check = parser.parsed;
        let solver = LightUpSolver(check)
        XCTAssert(solver.solve())
    }
}