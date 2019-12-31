//
//  FillominoBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 12/30/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class FillominoBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var clues:[[Int?]] = []
    private var wantText = false
    private var curClue:String = "";
    
    lazy var parsed:FillominoBoard = parse();
    
    public init(source:String){
        self.source = source;
    }
    
    private func parse() -> FillominoBoard {
        let parser = XMLParser(data: source.data(using: .utf8) ?? Data())
        parser.delegate = self;
        parser.parse();
        return FillominoBoard(clues);
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        if elementName == "tr" {
            clues.append([])
        }
        else if elementName == "td" {
            if let clazz = attributeDict["class"] {
                if (clazz == "fillingfixed") {
                    wantText = true
                    curClue = ""
                }
            }
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
        if wantText {
            wantText = false
            clues[clues.count - 1].append(Int(curClue))
        }
        else {
            clues[clues.count - 1].append(nil)
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog(parseError.localizedDescription);
    }    
}
