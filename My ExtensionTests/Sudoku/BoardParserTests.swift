//
//  BoardParserTest.swift
//  My ExtensionTests
//
//  Created by mark on 11/12/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class BoardParserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMinimal() {
        let parser = SudokuBoardParser(source: "<container><input value=\"1\"/></container>");
        let check = parser.parsed;
        XCTAssertEqual("1", check);
    }

    func testUnterminatedInput() {
        let parser = SudokuBoardParser(source: "<container><p><input value=\"1\"></p><p><input value=\"2\"></p></container>");
        let check = parser.parsed;
        XCTAssertEqual("12", check);
    }

    func testEmptyValue() {
        let parser = SudokuBoardParser(source: "<container><input value=\"\"/></container>");
        let check = parser.parsed;
        XCTAssertEqual(".", check);
    }
    
    func testReal() {
        let source = """
<tbody><tr>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td11">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA11" onkeyup="keypressed(event , 1 , 1 , false)" onblur="lostfocus(1 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td12">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA12" onkeyup="keypressed(event , 1 , 2 , false)" onblur="lostfocus(1 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td13">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA13" onkeyup="keypressed(event , 1 , 3 , false)" onblur="lostfocus(1 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td14">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA14" onkeyup="keypressed(event , 1 , 4 , false)" onblur="lostfocus(1 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td15">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA15" onkeyup="keypressed(event , 1 , 5 , false)" onblur="lostfocus(1 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td16">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA16" onkeyup="keypressed(event , 1 , 6 , false)" onblur="lostfocus(1 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td17">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA17" onkeyup="keypressed(event , 1 , 7 , false)" onblur="lostfocus(1 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td18">
<p class="c"><input class="n" maxlength="9" readonly="" value="4" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA18" onkeyup="keypressed(event , 1 , 8 , false)" onblur="lostfocus(1 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td19">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA19" onkeyup="keypressed(event , 1 , 9 , false)" onblur="lostfocus(1 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td21">
<p class="c"><input class="n" maxlength="9" readonly="" value="6" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA21" onkeyup="keypressed(event , 2 , 1 , false)" onblur="lostfocus(2 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td22">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA22" onkeyup="keypressed(event , 2 , 2 , false)" onblur="lostfocus(2 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td23">
<p class="c"><input class="n" maxlength="9" readonly="" value="8" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA23" onkeyup="keypressed(event , 2 , 3 , false)" onblur="lostfocus(2 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td24">
<p class="c"><input class="n" maxlength="9" readonly="" value="4" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA24" onkeyup="keypressed(event , 2 , 4 , false)" onblur="lostfocus(2 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td25">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA25" onkeyup="keypressed(event , 2 , 5 , false)" onblur="lostfocus(2 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td26">
<p class="c"><input class="n" maxlength="9" readonly="" value="9" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA26" onkeyup="keypressed(event , 2 , 6 , false)" onblur="lostfocus(2 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td27">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA27" onkeyup="keypressed(event , 2 , 7 , false)" onblur="lostfocus(2 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td28">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA28" onkeyup="keypressed(event , 2 , 8 , false)" onblur="lostfocus(2 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td29">
<p class="c"><input class="n" maxlength="9" readonly="" value="3" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA29" onkeyup="keypressed(event , 2 , 9 , false)" onblur="lostfocus(2 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td31">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA31" onkeyup="keypressed(event , 3 , 1 , false)" onblur="lostfocus(3 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td32">
<p class="c"><input class="n" maxlength="9" readonly="" value="2" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA32" onkeyup="keypressed(event , 3 , 2 , false)" onblur="lostfocus(3 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td33">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA33" onkeyup="keypressed(event , 3 , 3 , false)" onblur="lostfocus(3 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td34">
<p class="c"><input class="n" maxlength="9" readonly="" value="7" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA34" onkeyup="keypressed(event , 3 , 4 , false)" onblur="lostfocus(3 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td35">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA35" onkeyup="keypressed(event , 3 , 5 , false)" onblur="lostfocus(3 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td36">
<p class="c"><input class="n" maxlength="9" readonly="" value="6" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA36" onkeyup="keypressed(event , 3 , 6 , false)" onblur="lostfocus(3 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td37">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA37" onkeyup="keypressed(event , 3 , 7 , false)" onblur="lostfocus(3 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td38">
<p class="c"><input class="n" maxlength="9" readonly="" value="1" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA38" onkeyup="keypressed(event , 3 , 8 , false)" onblur="lostfocus(3 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td39">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA39" onkeyup="keypressed(event , 3 , 9 , false)" onblur="lostfocus(3 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td41">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA41" onkeyup="keypressed(event , 4 , 1 , false)" onblur="lostfocus(4 , 1)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td42">
<p class="c"><input class="n" maxlength="9" readonly="" value="9" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA42" onkeyup="keypressed(event , 4 , 2 , false)" onblur="lostfocus(4 , 2)"></p>
</td>

<td width="46" height="46" class="stopright" style="background-color: #dddddd;" id="td43">
<p class="c"><input class="n" maxlength="9" readonly="" value="3" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA43" onkeyup="keypressed(event , 4 , 3 , false)" onblur="lostfocus(4 , 3)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td44">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA44" onkeyup="keypressed(event , 4 , 4 , false)" onblur="lostfocus(4 , 4)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td45">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA45" onkeyup="keypressed(event , 4 , 5 , false)" onblur="lostfocus(4 , 5)"></p>
</td>

<td width="46" height="46" class="stopright" style="background-color: #dddddd;" id="td46">
<p class="c"><input class="n" maxlength="9" readonly="" value="4" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA46" onkeyup="keypressed(event , 4 , 6 , false)" onblur="lostfocus(4 , 6)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td47">
<p class="c"><input class="n" maxlength="9" readonly="" value="2" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA47" onkeyup="keypressed(event , 4 , 7 , false)" onblur="lostfocus(4 , 7)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td48">
<p class="c"><input class="n" maxlength="9" readonly="" value="8" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA48" onkeyup="keypressed(event , 4 , 8 , false)" onblur="lostfocus(4 , 8)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td49">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA49" onkeyup="keypressed(event , 4 , 9 , false)" onblur="lostfocus(4 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td51">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA51" onkeyup="keypressed(event , 5 , 1 , false)" onblur="lostfocus(5 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td52">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA52" onkeyup="keypressed(event , 5 , 2 , false)" onblur="lostfocus(5 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td53">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA53" onkeyup="keypressed(event , 5 , 3 , false)" onblur="lostfocus(5 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td54">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA54" onkeyup="keypressed(event , 5 , 4 , false)" onblur="lostfocus(5 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td55">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA55" onkeyup="keypressed(event , 5 , 5 , false)" onblur="lostfocus(5 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td56">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA56" onkeyup="keypressed(event , 5 , 6 , false)" onblur="lostfocus(5 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td57">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA57" onkeyup="keypressed(event , 5 , 7 , false)" onblur="lostfocus(5 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td58">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA58" onkeyup="keypressed(event , 5 , 8 , false)" onblur="lostfocus(5 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td59">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA59" onkeyup="keypressed(event , 5 , 9 , false)" onblur="lostfocus(5 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td61">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA61" onkeyup="keypressed(event , 6 , 1 , false)" onblur="lostfocus(6 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td62">
<p class="c"><input class="n" maxlength="9" readonly="" value="4" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA62" onkeyup="keypressed(event , 6 , 2 , false)" onblur="lostfocus(6 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td63">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA63" onkeyup="keypressed(event , 6 , 3 , false)" onblur="lostfocus(6 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td64">
<p class="c"><input class="n" maxlength="9" readonly="" value="2" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA64" onkeyup="keypressed(event , 6 , 4 , false)" onblur="lostfocus(6 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td65">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA65" onkeyup="keypressed(event , 6 , 5 , false)" onblur="lostfocus(6 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td66">
<p class="c"><input class="n" maxlength="9" readonly="" value="8" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA66" onkeyup="keypressed(event , 6 , 6 , false)" onblur="lostfocus(6 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td67">
<p class="c"><input class="n" maxlength="9" readonly="" value="1" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA67" onkeyup="keypressed(event , 6 , 7 , false)" onblur="lostfocus(6 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td68">
<p class="c"><input class="n" maxlength="9" readonly="" value="6" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA68" onkeyup="keypressed(event , 6 , 8 , false)" onblur="lostfocus(6 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td69">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA69" onkeyup="keypressed(event , 6 , 9 , false)" onblur="lostfocus(6 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td71">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA71" onkeyup="keypressed(event , 7 , 1 , false)" onblur="lostfocus(7 , 1)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td72">
<p class="c"><input class="n" maxlength="9" readonly="" value="3" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA72" onkeyup="keypressed(event , 7 , 2 , false)" onblur="lostfocus(7 , 2)"></p>
</td>

<td width="46" height="46" class="stopright" style="background-color: #ffffff;" id="td73">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA73" onkeyup="keypressed(event , 7 , 3 , false)" onblur="lostfocus(7 , 3)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td74">
<p class="c"><input class="n" maxlength="9" readonly="" value="6" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA74" onkeyup="keypressed(event , 7 , 4 , false)" onblur="lostfocus(7 , 4)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td75">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA75" onkeyup="keypressed(event , 7 , 5 , false)" onblur="lostfocus(7 , 5)"></p>
</td>

<td width="46" height="46" class="stopright" style="background-color: #dddddd;" id="td76">
<p class="c"><input class="n" maxlength="9" readonly="" value="1" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA76" onkeyup="keypressed(event , 7 , 6 , false)" onblur="lostfocus(7 , 6)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td77">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA77" onkeyup="keypressed(event , 7 , 7 , false)" onblur="lostfocus(7 , 7)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #dddddd;" id="td78">
<p class="c"><input class="n" maxlength="9" readonly="" value="9" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA78" onkeyup="keypressed(event , 7 , 8 , false)" onblur="lostfocus(7 , 8)"></p>
</td>

<td width="46" height="46" class="stop" style="background-color: #ffffff;" id="td79">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA79" onkeyup="keypressed(event , 7 , 9 , false)" onblur="lostfocus(7 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td81">
<p class="c"><input class="n" maxlength="9" readonly="" value="2" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA81" onkeyup="keypressed(event , 8 , 1 , false)" onblur="lostfocus(8 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td82">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA82" onkeyup="keypressed(event , 8 , 2 , false)" onblur="lostfocus(8 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td83">
<p class="c"><input class="n" maxlength="9" readonly="" value="6" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA83" onkeyup="keypressed(event , 8 , 3 , false)" onblur="lostfocus(8 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td84">
<p class="c"><input class="n" maxlength="9" readonly="" value="9" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA84" onkeyup="keypressed(event , 8 , 4 , false)" onblur="lostfocus(8 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td85">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA85" onkeyup="keypressed(event , 8 , 5 , false)" onblur="lostfocus(8 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #dddddd;" id="td86">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA86" onkeyup="keypressed(event , 8 , 6 , false)" onblur="lostfocus(8 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td87">
<p class="c"><input class="n" maxlength="9" readonly="" value="3" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA87" onkeyup="keypressed(event , 8 , 7 , false)" onblur="lostfocus(8 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td88">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA88" onkeyup="keypressed(event , 8 , 8 , false)" onblur="lostfocus(8 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td89">
<p class="c"><input class="n" maxlength="9" readonly="" value="1" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA89" onkeyup="keypressed(event , 8 , 9 , false)" onblur="lostfocus(8 , 9)"></p>
</td>

</tr>

<tr>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td91">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA91" onkeyup="keypressed(event , 9 , 1 , false)" onblur="lostfocus(9 , 1)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td92">
<p class="c"><input class="n" maxlength="9" readonly="" value="1" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA92" onkeyup="keypressed(event , 9 , 2 , false)" onblur="lostfocus(9 , 2)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td93">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA93" onkeyup="keypressed(event , 9 , 3 , false)" onblur="lostfocus(9 , 3)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td94">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA94" onkeyup="keypressed(event , 9 , 4 , false)" onblur="lostfocus(9 , 4)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td95">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA95" onkeyup="keypressed(event , 9 , 5 , false)" onblur="lostfocus(9 , 5)"></p>
</td>

<td width="46" height="46" class="sright" style="background-color: #ffffff;" id="td96">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA96" onkeyup="keypressed(event , 9 , 6 , false)" onblur="lostfocus(9 , 6)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td97">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA97" onkeyup="keypressed(event , 9 , 7 , false)" onblur="lostfocus(9 , 7)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #dddddd;" id="td98">
<p class="c"><input class="n" maxlength="9" readonly="" value="5" style="color: rgb(0, 51, 153);" autocomplete="off" id="BBsudokuinputA98" onkeyup="keypressed(event , 9 , 8 , false)" onblur="lostfocus(9 , 8)"></p>
</td>

<td width="46" height="46" class="s" style="background-color: #ffffff;" id="td99">
<p class="c"><input class="n" maxlength="9" value="" autocomplete="off" id="BBsudokuinputA99" onkeyup="keypressed(event , 9 , 9 , false)" onblur="lostfocus(9 , 9)"></p>
</td>

</tr>

</tbody>
"""
        let parser = SudokuBoardParser(source: source);
        let check = parser.parsed;
        XCTAssertEqual("""
.5.....4.6.84.95.3.2.7.6.1..935.428...........452.816..3.6.1.9.2.69.53.1.1.....5.
""", check);
    }
}

