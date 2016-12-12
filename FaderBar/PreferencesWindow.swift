//
//  PreferencesWindow.swift
//  FaderBar
//
//  Created by iain on 12/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController {
    @IBOutlet weak var fadeTimeField: NSTextField!
    
    override var windowNibName: String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
