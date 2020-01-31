//
//  LightUpBoardParser.swift
//  My Extension Extension
//
//  Created by mark on 1/16/20.
//  Copyright © 2020 Mark Dixon. All rights reserved.
//

import Foundation

public class LightUpBoardParser : NSObject, XMLParserDelegate {
    private let source:String;
    private var clues:[[Int?]] = []
    
    lazy var parsed:LightUpBoard = parse();
    
    public init(source:String){
        self.source = source;
    }
    
    private func parse() -> LightUpBoard {
        let fixedSource = source.replacingOccurrences(of: "\"></", with:"\"/></")
        let parser = XMLParser(data: fixedSource.data(using: .utf8) ?? Data())
        parser.delegate = self;
        parser.parse();
        return LightUpBoard(clues);
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        if elementName == "tr" {
            clues.append([])
        }
        else if elementName == "img" {
            if let src = attributeDict["src"] {
                if src.contains("/clu") {
                    let c = src.suffix(5).prefix(1)
                    var i = Int(c)
                    if i == nil {
                        i = 9
                    }
                    clues[clues.count - 1].append(i)
                }
                else {
                    clues[clues.count - 1].append(nil);
                }
            }
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog(parseError.localizedDescription);
    }
}
