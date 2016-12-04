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
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength);
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu;
        statusItem.title = "FaderBar";
        
        // TODO: icon
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self);
    }
}
