//
//  KillerSudokuBoardParser.swift
//  My Extension
//
//  Created by mark on 11/15/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class KillerSudokuBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var totals:[Int] = []
    private var types:[Int] = []
    
    lazy var parsed:KillerSudokuBoard = parse();
    
    public init(source:String){
        self.source = source;
    }
    
    private func parse() -> KillerSudokuBoard {
        let fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></");
        let parser = XMLParser(data: fixedSource.data(using: .utf8) ?? Data())
        parser.delegate = self;
        parser.parse();
        return buildBoard();
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        guard elementName == "td" else {
            return;
        }
        guard let value = attributeDict["class"] else {
            return;
        }
        guard value == "s" || value == "sright" || value == "stop" || value == "stopright" else {
            return;
        }
        guard let style = attributeDict["style"] else {
            return;
        }
        let nsrange = NSRange(style.startIndex..<style.endIndex, in: style)
        let regexClue = try! NSRegularExpression(pattern: #"clue(\d+)_(\d+)\.gif"#, options: [])
        let regexDots = try! NSRegularExpression(pattern: #"dots(\d+)\.gif"#, options: [])

        if let match = regexClue.firstMatch(in: style, options: [], range: nsrange) {
            let type = Int(substring(str:style, range:match.range(at: 1)))
            let target = Int(substring(str:style,range:match.range(at: 2)))
            totals.append(target!)
            types.append(type!)
        }
        else if let match  = regexDots.firstMatch(in: style, options: [], range: nsrange) {
            let type = Int(substring(str:style, range:match.range(at: 1)))
            totals.append(0)
            types.append(type!)
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog(parseError.localizedDescription);
    }
    
    private func substring(str:String, range:NSRange) -> String {
        let start = str.index(str.startIndex, offsetBy: range.lowerBound)
        let end = str.index(str.startIndex, offsetBy: range.upperBound)
        let substr = str[start..<end]
        return String(substr)
    }
    
    private func buildBoard() -> KillerSudokuBoard {
        let answer = KillerSudokuBoard()
        for i in 0...80 {
            if (0 != totals[i]) {
                answer.addBlock(block: buildBlock(at:i))
            }
        }
        return answer;
    }
    
    private func buildBlock(at:Int) -> KillerSudokuBoard.Block {
        var todo = [at]
        var cells:[Int] = []
        
        while (0 != todo.count) {
            let i = todo[0]
            if (!cells.contains(i)) {
                cells.append(i)
                let type = types[i]
                if (type == 1 || type == 3 || type == 5 || type == 7 || type == 9 || type == 11 || type == 13 || type == 15) {
                    todo.append(i - 9)
                }
                if (8 <= type) {
                    todo.append(i - 1);
                }
                if (type == 2 || type == 3 || type == 6 || type == 7 || type == 10 || type == 11 || type == 14 || type == 15) {
                    todo.append(i + 1)
                }
                if (type == 4 || type == 5 || type == 6 || type == 7 || type == 12 || type == 13 || type == 14 || type == 15) {
                    todo.append(i + 9)
                }
            }
            todo.remove(at: 0)
        }
        return KillerSudokuBoard.Block(target:totals[at], cells:cells)
    }
    
}
