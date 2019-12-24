//
//  BridgesBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 12/23/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class BridgesBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var board:BridgesBoard = BridgesBoard()
    private var i:Int = -1
    private var j:Int = 0

    lazy var parsed:BridgesBoard = parse();

    public init(source:String){
        self.source = source;
    }

    private func parse() -> BridgesBoard {
        let fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></")
        let fixedSource2 = fixedSource.replacingOccurrences(of: "\">\n</", with:"\"/></")
        let parser = XMLParser(data: fixedSource2.data(using: .utf8) ?? Data())
        parser.delegate = self;
        parser.parse();
        board.buildLines()
        return board;
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){

        if elementName == "img" {
            guard attributeDict["id"] != nil else {
                return
            }
            guard let src = attributeDict["src"] else {
                return
            }
            let clue = Int(src.suffix(from: src.index(src.startIndex, offsetBy: 18)).prefix(1))
            if clue != nil {
                board.addClue(clue:clue!, i:i, j:j)
            }
            j = j + 1
        }
        else if elementName == "tr" {
            if (0 == i) {
                board.dim = j
            }
            i = i + 1
            j = 0
        }
    }
}
