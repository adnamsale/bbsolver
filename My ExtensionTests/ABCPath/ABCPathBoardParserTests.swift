//
//  ABCPathBoardParserTests.swift
//  My ExtensionTests
//
//  Created by mark on 12/19/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import XCTest

class ABCPathBoardParserTests: XCTestCase {
    func testReal() {
            let source = """
<tbody><tr>

<td><img src="/gifs_abcpath_new/4P.jpg" id="clue1" name="clue1"></td>

<td><img src="/gifs_abcpath_new/5K.jpg" id="clue2" name="clue2"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/5F.jpg" id="clue3" name="clue3"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/5O.jpg" id="clue4" name="clue4"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/5X.jpg" id="clue5" name="clue5"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/5V.jpg" id="clue6" name="clue6"></td>

<td><img src="/gifs_abcpath_new/6L.jpg" id="clue7" name="clue7"></td>

</tr>


<tr>


<td><img src="/gifs_abcpath_new/3E.jpg" id="clue8" name="clue8"></td>

<td class="ABCtd" style="" id="td11">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput11" onfocus="setfocusvars(11);" onkeyup="keypressed(event , 1 , 1 , true);" onblur="lostfocus(1 , 1)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td12">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput12" onfocus="setfocusvars(12);" onkeyup="keypressed(event , 1 , 2 , true);" onblur="lostfocus(1 , 2)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td13">
<input class="ABCq" readonly="" maxlength="9" value="A" autocomplete="off" id="BBabcpathinput13" onfocus="setfocusvars(13);" onkeyup="keypressed(event , 1 , 3 , true);" onblur="lostfocus(1 , 3)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td14">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput14" onfocus="setfocusvars(14);" onkeyup="keypressed(event , 1 , 4 , true);" onblur="lostfocus(1 , 4)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td15">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput15" onfocus="setfocusvars(15);" onkeyup="keypressed(event , 1 , 5 , true);" onblur="lostfocus(1 , 5)">
</td>

<td><img src="/gifs_abcpath_new/7C.jpg" id="clue14" name="clue14"></td>
</tr>
<tr>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

</tr>


<tr>


<td><img src="/gifs_abcpath_new/3D.jpg" id="clue15" name="clue15"></td>

<td class="ABCtd" style="" id="td21">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput21" onfocus="setfocusvars(21);" onkeyup="keypressed(event , 2 , 1 , true);" onblur="lostfocus(2 , 1)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td22">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput22" onfocus="setfocusvars(22);" onkeyup="keypressed(event , 2 , 2 , true);" onblur="lostfocus(2 , 2)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td23">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput23" onfocus="setfocusvars(23);" onkeyup="keypressed(event , 2 , 3 , true);" onblur="lostfocus(2 , 3)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td24">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput24" onfocus="setfocusvars(24);" onkeyup="keypressed(event , 2 , 4 , true);" onblur="lostfocus(2 , 4)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td25">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput25" onfocus="setfocusvars(25);" onkeyup="keypressed(event , 2 , 5 , true);" onblur="lostfocus(2 , 5)">
</td>

<td><img src="/gifs_abcpath_new/7W.jpg" id="clue21" name="clue21"></td>
</tr>
<tr>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

</tr>


<tr>


<td><img src="/gifs_abcpath_new/3T.jpg" id="clue22" name="clue22"></td>

<td class="ABCtd" style="" id="td31">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput31" onfocus="setfocusvars(31);" onkeyup="keypressed(event , 3 , 1 , true);" onblur="lostfocus(3 , 1)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td32">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput32" onfocus="setfocusvars(32);" onkeyup="keypressed(event , 3 , 2 , true);" onblur="lostfocus(3 , 2)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td33">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput33" onfocus="setfocusvars(33);" onkeyup="keypressed(event , 3 , 3 , true);" onblur="lostfocus(3 , 3)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td34">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput34" onfocus="setfocusvars(34);" onkeyup="keypressed(event , 3 , 4 , true);" onblur="lostfocus(3 , 4)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td35">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput35" onfocus="setfocusvars(35);" onkeyup="keypressed(event , 3 , 5 , true);" onblur="lostfocus(3 , 5)">
</td>

<td><img src="/gifs_abcpath_new/7G.jpg" id="clue28" name="clue28"></td>
</tr>
<tr>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

</tr>


<tr>


<td><img src="/gifs_abcpath_new/3I.jpg" id="clue29" name="clue29"></td>

<td class="ABCtd" style="" id="td41">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput41" onfocus="setfocusvars(41);" onkeyup="keypressed(event , 4 , 1 , true);" onblur="lostfocus(4 , 1)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td42">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput42" onfocus="setfocusvars(42);" onkeyup="keypressed(event , 4 , 2 , true);" onblur="lostfocus(4 , 2)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td43">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput43" onfocus="setfocusvars(43);" onkeyup="keypressed(event , 4 , 3 , true);" onblur="lostfocus(4 , 3)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td44">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput44" onfocus="setfocusvars(44);" onkeyup="keypressed(event , 4 , 4 , true);" onblur="lostfocus(4 , 4)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td45">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput45" onfocus="setfocusvars(45);" onkeyup="keypressed(event , 4 , 5 , true);" onblur="lostfocus(4 , 5)">
</td>

<td><img src="/gifs_abcpath_new/7S.jpg" id="clue35" name="clue35"></td>
</tr>
<tr>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="10" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

<td><img src="/gifs/sp.gif" width="50" height="10"></td>

</tr>


<tr>


<td><img src="/gifs_abcpath_new/3N.jpg" id="clue36" name="clue36"></td>

<td class="ABCtd" style="" id="td51">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput51" onfocus="setfocusvars(51);" onkeyup="keypressed(event , 5 , 1 , true);" onblur="lostfocus(5 , 1)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td52">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput52" onfocus="setfocusvars(52);" onkeyup="keypressed(event , 5 , 2 , true);" onblur="lostfocus(5 , 2)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td53">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput53" onfocus="setfocusvars(53);" onkeyup="keypressed(event , 5 , 3 , true);" onblur="lostfocus(5 , 3)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td54">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput54" onfocus="setfocusvars(54);" onkeyup="keypressed(event , 5 , 4 , true);" onblur="lostfocus(5 , 4)">
</td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td class="ABCtd" style="" id="td55">
<input class="ABCn" maxlength="9" value="" autocomplete="off" id="BBabcpathinput55" onfocus="setfocusvars(55);" onkeyup="keypressed(event , 5 , 5 , true);" onblur="lostfocus(5 , 5)">
</td>

<td><img src="/gifs_abcpath_new/7R.jpg" id="clue42" name="clue42"></td>
</tr>
<tr>

</tr>


<tr>

<td><img src="/gifs_abcpath_new/2U.jpg" id="clue43" name="clue43"></td>

<td><img src="/gifs_abcpath_new/1J.jpg" id="clue44" name="clue44"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/1M.jpg" id="clue45" name="clue45"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/1B.jpg" id="clue46" name="clue46"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/1Q.jpg" id="clue47" name="clue47"></td>

<td><img src="/gifs/sp.gif" width="10" height="50"></td>

<td><img src="/gifs_abcpath_new/1Y.jpg" id="clue48" name="clue48"></td>

<td><img src="/gifs_abcpath_new/8H.jpg" id="clue49" name="clue49"></td>

</tr>
</tbody>
"""
        let parser = ABCPathBoardParser(source: source);
        let check = parser.parsed;
        let solver = ABCPathSolver(check)
        XCTAssert(solver.solve())
    }
}
