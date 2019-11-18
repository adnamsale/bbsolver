//
//  SafariExtensionHandler.swift
//  My Extension Extension
//
//  Created by mark on 11/7/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    var page: SFSafariPage? = nil;
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a new message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
            if (!messageName.starts(with: "Null")) {
                let solution = self.solve(source: messageName)
                page.dispatchMessageToScript(withName: "simpleMessage", userInfo: solution)
            }
        }
        self.page = page;
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was Mondayed")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

    private func solve(source:String) -> [String:Any]{
        var answer:[String:Any] = [String:Any]()
        let parser = KillerSudokuBoardParser(source:source)
        let board = parser.parsed;
        let solver = KillerSudokuSolver(board:board)
        if (solver.solve()) {
            answer["solution"] = solver.solution
        }
        else {
            answer["error"] = "No solution found"
        }
        return answer;
    }    
}
