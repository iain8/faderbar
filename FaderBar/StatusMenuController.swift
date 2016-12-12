//
//  StatusMenuController.swift
//  FaderBar
//
//  Created by iain on 04/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var actionButton: NSMenuItem!;
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength);
    let volumeControl = VolumeControl();
    
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu;
        
        let icon = #imageLiteral(resourceName: "statusIcon");
        icon.isTemplate = false;
        statusItem.image = icon;
    }
    
    @IBAction func startClicked(_ sender: Any) {
        if (actionButton.title == "Start") {
            actionButton.setTitleWithMnemonic("Stop");
            
            volumeControl.startShrinkage();
        } else {
            actionButton.setTitleWithMnemonic("Start");
            
            volumeControl.cancelShrinkage();
        }
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self);
    }
}
