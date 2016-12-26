//
//  VolumeControl.swift
//  FaderBar
//
//  Created by iain on 04/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Foundation

/// Default fade length in seconds
struct Defaults {
    static let fadeLength = 1800.0
}

class VolumeControl {

    /// Timer used for scheduling
    var timer: Timer

    /// Initial volume when schedule started
    var initialVolume: Double

    /// Amount to change volume;
    var delta: Double

    /// Length of fade (in seconds)
    var fadeLength: Double

    /**

        Initialises a volume control with default parameters

        - Returns: A new volume control

    */
    init() {
        self.timer = Timer()
        self.initialVolume = 0.0
        self.delta = 0.0
        self.fadeLength = Defaults.fadeLength
    }

    /**

        Set the volume based on the delta from the current volume.

    */
    @objc func changeVolume() {
        let currentVolume = Double(NSSound.systemVolume())
        let newVolume = Float(currentVolume - delta)

        print("volume change:", currentVolume, newVolume)

        if newVolume > 0 {
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
    func showNotification(message: String) -> Void {
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
        self.timer.invalidate()

        self.initialVolume = Double(NSSound.systemVolume())

        let interval = self.fadeLength / 60.0

        // calculate change per interval from number of times timer is called
        self.delta = self.initialVolume / (self.fadeLength / interval)

        self.timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(self.changeVolume),
            userInfo: nil,
            repeats: true
        )

        self.showNotification(message: "Fade out of \(UInt(self.fadeLength)) minutes started")
    }

    /**

        Cancel the volume scheduling and return to originally set volume

    */
    func cancelShrinkage() -> Void {
        self.timer.invalidate()

        NSSound.setSystemVolume(Float(initialVolume))
    }
}
