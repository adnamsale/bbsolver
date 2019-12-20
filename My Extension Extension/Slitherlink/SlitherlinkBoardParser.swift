//
//  SlitherlinkBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 11/26/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class SlitherlinkBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var clues:[Int?] = []
    private var dim:Int = 0
    private var wantText = false
    private var curClue:String = "";
    
    lazy var parsed:SlitherlinkBoard = parse();
    
    public init(source:String){
        self.source = source;
    }
    
    private func parse() -> SlitherlinkBoard {
        let regex = try! NSRegularExpression(pattern:#"(<img[^>]+)>"#, options:[])
        let fixedSource = regex.stringByReplacingMatches(in: source, options: [], range: NSMakeRange(0, source.count), withTemplate: "$1/>")
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
        guard value == "plooptext" else {
            return;
        }
        guard let id = attributeDict["id"] else {
            return;
        }
        let nsrange = NSRange(id.startIndex..<id.endIndex, in: id)
        let regexClue = try! NSRegularExpression(pattern: #"clue_(\d+)_(\d+)"#, options: [])

        if let match = regexClue.firstMatch(in: id, options: [], range: nsrange) {
            let row = Int(substring(str:id, range:match.range(at: 1)))!
            let col = Int(substring(str:id,range:match.range(at: 2)))!
            dim = max(dim, max(row, col))
            wantText = true
            curClue = ""
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (wantText) {
            curClue = string
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == "td" else {
            return
        }
        guard (wantText) else {
            return
        }
        wantText = false
        if (1 == curClue.count) {
            clues.append(Int(curClue))
        }
        else {
            clues.append(nil)
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
    
    private func buildBoard() -> SlitherlinkBoard {
        let answer = SlitherlinkBoard(clues:clues, dim:dim + 1)!
        return answer;
    }
}
