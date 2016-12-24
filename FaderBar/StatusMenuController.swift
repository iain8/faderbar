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

    /// Time indicator in menu
    @IBOutlet weak var timeIndicator: NSMenuItem!

    /// Status bar item
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    /// Volume controller
    let volumeControl = VolumeControl()

    /// The preferences window
    var preferencesWindow: PreferencesWindow!

    /// Black and white icon
    let bwIcon = #imageLiteral(resourceName: "bwStatusIcon")

    /// Colour icon
    let colourIcon = #imageLiteral(resourceName: "statusIcon")

    /// Timer for menu item
    var timer: Timer = Timer()

    var endDate: Date = Date()

    /**

        Set up menu properties

    */
    override func awakeFromNib() {
        statusItem.menu = statusMenu

        colourIcon.isTemplate = false
        bwIcon.isTemplate = false
        statusItem.image = bwIcon

        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
    }

    /**

        Start or fade out and switch menu label

    */
    @IBAction func startClicked(_ sender: Any) {
        if actionButton.title == "Start" {
            statusItem.image = colourIcon

            actionButton.setTitleWithMnemonic("Stop")

            volumeControl.startShrinkage()

            self.endDate = Date().addingTimeInterval(volumeControl.fadeLength * 60.0)

            self.setTimeDisplay()

            self.timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(self.setTimeDisplay),
                userInfo: nil,
                repeats: true
            )
        } else {
            volumeControl.cancelShrinkage()

            self.timer.invalidate()

            statusItem.image = bwIcon

            actionButton.setTitleWithMnemonic("Start")

            let fadeTime = UserDefaults.standard.double(forKey: "fadeTime")

            timeIndicator.setTitleWithMnemonic("Fade time: \(TimeHelper.formatInterval(interval: fadeTime * 60))")
        }
    }

    /**

        Show preferences panel

    */
    @IBAction func preferencesClicked(_ sender: Any) {
        preferencesWindow.showWindow(nil)
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
        let fadeTime = UserDefaults.standard.double(forKey: "fadeTime")

        self.volumeControl.fadeLength = fadeTime

        self.timeIndicator.setTitleWithMnemonic("Fade time: \(TimeHelper.formatInterval(interval: fadeTime * 60))")
    }

    /**

        Set time display in menu

    */
    func setTimeDisplay() {
        let difference = Date().timeIntervalSince(self.endDate) * -1.0

        if difference > 0 {
            self.timeIndicator.setTitleWithMnemonic("Fade left: \(TimeHelper.formatInterval(interval: difference))")
        } else {
            self.timeIndicator.setTitleWithMnemonic("Muted!")

            actionButton.setTitleWithMnemonic("Reset")

            self.timer.invalidate()

            if UserDefaults.standard.bool(forKey: "sleepAfterwards") {
                SystemTask.goToSleep()
            }
        }
    }
}
