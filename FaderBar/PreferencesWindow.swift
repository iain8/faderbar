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

/// Preferences window
class PreferencesWindow: NSWindowController, NSWindowDelegate {
    /// The fade out time field
    @IBOutlet weak var fadeTimeField: NSTextField!
    
    // The fade out time slider
    @IBOutlet weak var fadeTimeSlider: NSSlider!
    
    /// Window delegate
    var delegate: PreferencesWindowDelegate?
    
    /// Name of window
    override var windowNibName: String! {
        return "PreferencesWindow"
    }
    
    /**
        
        Populate preferences fields when window is opened
     
    */
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        fadeTimeField.stringValue = UserDefaults.standard.string(forKey: "fadeTime") ?? String(DEFAULT_FADELENGTH / 60.0)
    }
    
    
    @IBAction func fadeTimeChanged(_ sender: Any) {
        fadeTimeField.doubleValue = fadeTimeSlider.doubleValue;
    }
    
    /**
     
        "Done" button action
     
    */
    @IBAction func saveButtonClicked(_ sender: Any) {
        self.updatePreferences()
        
        self.window?.close()
    }
    
    /**
     
        On close preferences, update fade time
     
        - Parameter notification: Some kind of notification
     
    */
    func windowWillClose(_ notification: Notification) {
        self.updatePreferences()
    }
    
    /**
     
        Update preferences
     
    */
    func updatePreferences() {
        let defaults = UserDefaults.standard
        
        // TODO: doubleValue
        defaults.setValue(fadeTimeField.stringValue, forKey: "fadeTime")
        
        delegate?.preferencesDidUpdate()
    }
}
