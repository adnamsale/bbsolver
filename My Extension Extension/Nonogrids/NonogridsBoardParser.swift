//
//  NonogridsBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 3/28/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class NonogridsBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var board:NonogridsBoard
    private var firstRow:Bool?
    private var firstCol:Bool?
    private var wantText:Bool = false
    private var curClue:String = ""
    
    lazy var parsed:NonogridsBoard = parse();
    
    public init(source:String){
        self.source = source
        board = NonogridsBoard()
    }
    
    private func parse() -> NonogridsBoard {
        var fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></")
        fixedSource = fixedSource.replacingOccurrences(of: "<br>", with: "<br/>")
        fixedSource = fixedSource.replacingOccurrences(of: "&nbsp;", with: " ")
        let parser = XMLParser(data: fixedSource.data(using: .utf8) ?? Data())
        parser.delegate = self;
        parser.parse();
        return board
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        if elementName == "tr" {
            firstRow = firstRow == nil
            firstCol = nil
        }
        else if elementName == "td" {
            firstCol = firstCol == nil
            wantText = true
            curClue = ""
        }
        else if elementName == "br" {
            if (wantText) {
                curClue += " "
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (wantText) {
            curClue += string
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == "td" else {
            return
        }
        if wantText {
            wantText = false
            if (firstRow! && !firstCol!) {
                board.addDown(parseClue(curClue))
            }
            else if (firstCol! && !firstRow!) {
                board.addAcross(parseClue(curClue))
            }
        }
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog(parseError.localizedDescription);
    }
    
    private func parseClue(_ clue:String) -> [Int] {
        return clue.split(separator: " ").map { Int($0)! }
    }
}
