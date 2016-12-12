//
//  PreferencesWindow.swift
//  FaderBar
//
//  Created by iain on 12/12/16.
//  Copyright © 2016 iain. All rights reserved.
//
protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

import Cocoa

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var fadeTimeField: NSTextField!
    
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName: String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        fadeTimeField.stringValue = UserDefaults.standard.string(forKey: "fadeTime") ?? String(DEFAULT_FADELENGTH / 60.0)
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        
        defaults.setValue(fadeTimeField.stringValue, forKey: "fadeTime")
        
        delegate?.preferencesDidUpdate()
    }
}
