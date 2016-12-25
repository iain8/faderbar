//
//  SystemTask.swift
//  FaderBar
//
//  Created by iain on 24/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Foundation

class SystemTask {
    /**
        
        Sleep now!
     
    */
    static func goToSleep() {
        let task = Process()

        task.launchPath = "/usr/bin/pmset"
        task.arguments = ["sleepnow"]
        task.launch()
    }
}
