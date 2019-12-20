//
//  ABCPathBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 12/18/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class ABCPathBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var board:ABCPathBoard = ABCPathBoard()

    lazy var parsed:ABCPathBoard = parse();

    public init(source:String){
        self.source = source;
    }

    private func parse() -> ABCPathBoard {
        let fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></")
        let fixedSource2 = fixedSource.replacingOccurrences(of: "\">\n</", with:"\"/></")
        let parser = XMLParser(data: fixedSource2.data(using: .utf8) ?? Data())
        board = ABCPathBoard()
        parser.delegate = self;
        parser.parse();
        return board;
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){

        if elementName == "img" {
            guard let id = attributeDict["id"] else {
                return
            }
            guard let src = attributeDict["src"] else {
                return
            }
            let clue = Int(id.suffix(from: id.index(id.startIndex, offsetBy: 4)))!
            let letter = src.suffix(5).first!
            if clue == 1 || clue == 49 {
                board.addClue(letter, ABCPathBoard.Direction.DIAG, 0)
            }
            else if clue == 7 || clue == 43 {
                board.addClue(letter, ABCPathBoard.Direction.DIAG, 1)
            }
            else if 2...6 ~= clue {
                board.addClue(letter, ABCPathBoard.Direction.VER, clue - 2)
            }
            else if 44...48 ~= clue {
                board.addClue(letter, ABCPathBoard.Direction.VER, clue - 44)
            }
            else if clue % 7 == 1 {
                board.addClue(letter, ABCPathBoard.Direction.HOR, (clue - 1) / 7 - 1)
            }
            else if clue % 7 == 0 {
                board.addClue(letter, ABCPathBoard.Direction.HOR, clue / 7 - 2)
            }
        }
        else if elementName == "input" {
            guard let clazz = attributeDict["class"] else {
                return
            }
            guard let id = attributeDict["id"] else {
                return
            }
            if clazz == "ABCq" {
                let rowCol = id.suffix(2)
                let row = Int(rowCol.prefix(1))
                let col = Int(rowCol.suffix(1))
                board.setAPos(row! - 1, col! - 1)
            }
        }
    }
}
