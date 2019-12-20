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
                let solution = self.solve(source: messageName, userInfo: userInfo!)
                page.dispatchMessageToScript(withName: "simpleMessage", userInfo: solution)
            }
        }
        self.page = page;
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was Wednesdayed")
        window.getActiveTab { (tab:SFSafariTab?) in
            tab?.getActivePage(completionHandler: { (page:SFSafariPage?) in
                page?.dispatchMessageToScript(withName: "simpleMessage", userInfo: ["type":"Button"])
            })
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

    private func solve(source:String, userInfo:[String:Any]) -> [String:Any]{
        var answer:[String:Any] = [String:Any]()
        let type = userInfo["type"] as! String
        let source = userInfo["source"] as! String
        switch(type) {
        case "KillerSudoku":
            let parser = KillerSudokuBoardParser(source:source)
            let board = parser.parsed
            let solver = KillerSudokuSolver(board:board)
            if solver.solve() {
                answer["type"] = "Sudoku"
                answer["solution"] = solver.solution
            }
            else {
                answer["error"] = "No solution found for Killer Sudoku"
            }
            break
        case "Sudoku":
            let parser = SudokuBoardParser(source:source)
            let board = parser.parsed
            let solver = SudokuSolver(board:board)
            if solver.solve() {
                answer["type"] = "Sudoku"
                answer["solution"] = solver.solution
            }
            else {
                answer["error"] = "No solution found for Sudoku"
            }
            break
        case "Slitherlink":
            let parser = SlitherlinkBoardParser(source:source)
            let board = parser.parsed
            let solver = SlitherlinkSolver(board:board)
            if solver.solve() {
                answer["type"] = "Slitherlink"
                answer["solution"] = ["hor":solver.solution["hor"], "ver":solver.solution["ver"]]
            }
            else {
                answer["error"] = "No solution found for Slitherlink"
            }
            break
        case "ABCPath":
            let parser = ABCPathBoardParser(source:source)
            let board = parser.parsed;
            let solver = ABCPathSolver(board)
            if solver.solve() {
                answer["type"] = "ABCPath"
                answer["solution"] = solver.solution
            }
            else {
                answer["error"] = "No solution found for ABC Path"
            }
            break
        default:
            answer["error"] = "Unknown type: \(type)"
        }
        return answer;
    }    
}
