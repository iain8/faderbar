//
//  VolumeControl.swift
//  FaderBar
//
//  Created by iain on 04/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Foundation

/// Default fade length in minutes
let DEFAULT_FADELENGTH = 30.0

class VolumeControl {
    /// Time (in seconds) between volume changes
    let interval: UInt;
    
    /// Timer used for scheduling
    var timer: Timer;
    
    /// Initial volume when schedule started
    var initialVolume: Double;
    
    /// Amount to change volume;
    var delta: Double;
    
    /// Length of fade (in minutes)
    var fadeLength: Double;
    
    /**
     
        Initialises a volume control with default parameters
     
        - Returns: A new volume control
     
    */
    init() {
        self.timer = Timer()
        self.initialVolume = 0.0
        self.interval = 30
        self.delta = 0.0
        self.fadeLength = DEFAULT_FADELENGTH
        
        UserDefaults.standard.setValue(self.fadeLength, forKey: "fadeTime")
    }
    
    /**
       
        Set the volume based on the delta from the current volume.
     
    */
    @objc func changeVolume() {
        let currentVolume = Double(NSSound.systemVolume())
        let newVolume = Float(currentVolume - delta)
        
        if (newVolume > 0) {
            NSSound.setSystemVolume(newVolume)
        } else {
            NSSound.setSystemVolume(0.0)
            
            self.showNotification(message: "Sound muted")
            
            self.timer.invalidate()
        }
    }
    
    /**
     
        Show a notification
     
        - Parameter message: The notification contents
     
    */
    func showNotification(message:String) -> Void {
        let notification = NSUserNotification()
        notification.title = "Message from faderbar"
        notification.informativeText = message
        notification.soundName = nil
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    /**
     
        Start the volume reduction schedule
     
    */
    func startShrinkage() -> Void {
        self.timer.invalidate();
        
        self.initialVolume = Double(NSSound.systemVolume());
        
        // calculate change per interval from number of times timer is called
        self.delta = self.initialVolume / ((self.fadeLength * 60) / Double(self.interval));
        
        self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.changeVolume), userInfo: nil, repeats: true);
        
        self.showNotification(message: "Fade out of \(UInt(self.fadeLength)) minutes started")
    }
    
    /**
        
        Cancel the volume scheduling and return to originally set volume
     
    */
    func cancelShrinkage() -> Void {
        self.timer.invalidate();
        
        NSSound.setSystemVolume(Float(initialVolume));
    }
}
