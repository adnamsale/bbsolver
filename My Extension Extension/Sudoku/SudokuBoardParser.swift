//
//  BoardParser.swift
//  My Extension Extension
//
//  Created by mark on 11/12/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import Foundation

public class SudokuBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var board:String = "";
    
    lazy var parsed:String = parse();
    
    public init(source:String){
        self.source = source;
    }
    
    private func parse() -> String {
        let fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></");
        let parser = XMLParser(data: fixedSource.data(using: .utf8) ?? Data())
        board = "";
        parser.delegate = self;
        parser.parse();
        return board;
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        if (elementName == "input") {
            if let value = attributeDict["value"] {
                if (value.count == 1) {
                    let c:Character = value[value.startIndex];
                    if ("1" <= c && c <= "9") {
                        board += value;
                        return;
                    }
                }
            }
            board += ".";
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog(parseError.localizedDescription);
    }
}
