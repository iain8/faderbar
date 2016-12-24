//
//  PreferencesWindow.swift
//  FaderBar
//
//  Created by iain on 12/12/16.
//  Copyright © 2016 iain. All rights reserved.
//
protocol PreferencesWindowDelegate: class {
    func preferencesDidUpdate()
}

import Cocoa

/// Preferences window
class PreferencesWindow: NSWindowController, NSWindowDelegate {
    /// The fade out time field
    @IBOutlet weak var fadeTimeField: NSTextField!

    /// The fade out time slider
    @IBOutlet weak var fadeTimeSlider: NSSlider!

    /// Checkbox for post-fade sleep
    @IBOutlet weak var sleepCheckbox: NSButton!

    /// Window delegate
    weak var delegate: PreferencesWindowDelegate?

    /// Name of window
    override var windowNibName: String! {
        return "PreferencesWindow"
    }

    /// Time intervals for selector
    let timeIntervals: [Double] = [5.0, 10.0, 15.0, 30.0, 60.0, 120.0, 240.0, 360.0]

    /**
        
        Populate preferences fields when window is opened
     
    */
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        fadeTimeField.doubleValue = UserDefaults.standard.double(forKey: "fadeTime")
    }

    func windowDidBecomeMain(_ notification: Notification) {
        if (UserDefaults.standard.bool(forKey: "prefsDisabled")) {
            self.fadeTimeField.isEnabled = false
            self.fadeTimeSlider.isEnabled = false
        } else {
            self.fadeTimeField.isEnabled = true
            self.fadeTimeSlider.isEnabled = true
        }
    }

    /**
     
        Fade time slider action
     
    */
    @IBAction func fadeTimeChanged(_ sender: Any) {
        fadeTimeField.doubleValue = timeIntervals[fadeTimeSlider.integerValue]
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
        UserDefaults.standard.setValue(self.fadeTimeField.doubleValue, forKey: "fadeTime")
        UserDefaults.standard.setValue(self.sleepCheckbox.state, forKey: "sleepAfterwards")

        delegate?.preferencesDidUpdate()
    }
}
