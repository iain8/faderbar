//
//  StatusMenuController.swift
//  FaderBar
//
//  Created by iain on 04/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Cocoa

/// Status menu controller
class StatusMenuController: NSObject, PreferencesWindowDelegate {
    
    /// The whole menu!
    @IBOutlet weak var statusMenu: NSMenu!
    
    /// The start/stop button
    @IBOutlet weak var actionButton: NSMenuItem!
    
    /// Status bar item
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    /// Volume controller
    let volumeControl = VolumeControl()
    
    /// The preferences windwo
    var preferencesWindow: PreferencesWindow!
    
    /**
     
        Set up menu properties
     
    */
    override func awakeFromNib() {
        statusItem.menu = statusMenu
        
        let icon = #imageLiteral(resourceName: "statusIcon")
        icon.isTemplate = false
        statusItem.image = icon
        
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
    }
    
    /**
     
        Start or fade out and switch menu label
     
    */
    @IBAction func startClicked(_ sender: Any) {
        if (actionButton.title == "Start") {
            actionButton.setTitleWithMnemonic("Stop")
            
            volumeControl.startShrinkage()
        } else {
            actionButton.setTitleWithMnemonic("Start")
            
            volumeControl.cancelShrinkage()
        }
    }
    
    /**
     
        Show preferences panel
     
    */
    @IBAction func preferencesClicked(_ sender: Any) {
        preferencesWindow.showWindow(nil);
    }
    
    /**
     
        Close app when quit item selected
     
    */
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    /**
     
        Set new fade time when preferences window is closed
     
    */
    func preferencesDidUpdate() {
        let fadeTime = UserDefaults.standard.string(forKey: "fadeTime");
        
        let newFadeTime = Double(fadeTime!)
        
        volumeControl.fadeLength = newFadeTime! * 60.0
    }
}
