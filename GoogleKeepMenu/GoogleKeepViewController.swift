//
//  GoogleKeepViewController.swift
//  GoogleKeepMenu
//
//  Created by Brecht Machiels on 30/04/2018.
//  Copyright © 2018 MOS6581. All rights reserved.
//

import Cocoa
import WebKit

class GoogleKeepViewController: NSViewController {

    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://keep.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
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
            fatalError("Why cant i find GoogleKeepViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
