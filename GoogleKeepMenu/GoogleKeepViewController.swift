//
//  GoogleKeepViewController.swift
//  GoogleKeepMenu
//
//  Created by Brecht Machiels on 30/04/2018.
//  Copyright © 2018 MOS6581. All rights reserved.
//

import Cocoa

class GoogleKeepViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}


extension GoogleKeepViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> GoogleKeepViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "GoogleKeepViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? GoogleKeepViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
