//
//  VolumeControl.swift
//  FaderBar
//
//  Created by iain on 04/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Foundation

class VolumeControl {
    /// Timer used for scheduling
    var timer: Timer;
    
    /// Initial volume when schedule started
    var initialVolume: Double;
    
    /// Time (in seconds) between volume changes
    var interval: UInt;
    
    /// Amount to change volume;
    var delta: Double;
    
    /**
     
        Initialises a volume control with default parameters
     
        - Returns: A new volume control
     
    */
    init() {
        self.timer = Timer();
        self.initialVolume = 0.0;
        self.interval = 30;
        self.delta = 0.0;
    }
    
    /**
       
        Set the volume based on the delta from the current volume.
     
    */
    @objc func changeVolume() {
        let currentVolume = Double(NSSound.systemVolume());
        let newVolume = Float(currentVolume - delta);
        
        if (newVolume > 0) {
            NSSound.setSystemVolume(newVolume);
            
            self.showNotification(message: "Volume decreased by \(delta) to \(newVolume)")
        } else {
            NSSound.setSystemVolume(0.0);
            
            self.showNotification(message: "Sound muted")
            
            self.timer.invalidate();
        }
    }
    
    /**
     
        Show a notification
     
        - Parameter message: The notification contents
     
    */
    func showNotification(message:String) -> Void {
        let notification = NSUserNotification()
        notification.title = "Volume changed"
        notification.informativeText = message
        notification.soundName = nil
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    /**
     
        Start the volume reduction schedule
     
    */
    func startShrinkage() -> Void {
        self.timer.invalidate();
        
        initialVolume = Double(NSSound.systemVolume());
        
        delta = initialVolume / Double(interval);
        
        self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.changeVolume), userInfo: nil, repeats: true);
    }
    
    /**
        
        Cancel the volume scheduling and return to originally set volume
     
    */
    func cancelShrinkage() -> Void {
        self.timer.invalidate();
        
        NSSound.setSystemVolume(Float(initialVolume));
    }
}
