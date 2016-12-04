//
//  AppDelegate.swift
//  FaderBar
//
//  Created by iain on 03/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength);
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self);
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.title = "FaderBar";
        statusItem.menu = statusMenu;
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

