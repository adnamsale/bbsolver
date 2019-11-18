//
//  SafariExtensionViewController.swift
//  My Extension Extension
//
//  Created by mark on 11/7/19.
//  Copyright © 2019 Mark Dixon. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
