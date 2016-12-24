//
//  TimeHelper.swift
//  FaderBar
//
//  Created by iain on 21/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import Foundation

/// Helper functions relating to time
class TimeHelper {

    /**

        Format a time interval as a readable string

        - Parameter interal: Time interval in seconds

        - Returns: time formatted as "hh:mm"

    */
    static func formatInterval(interval: Double) -> String {
        let hours = self.addLeadingZero(numeral: UInt(interval) / 3600)
        let mins = self.addLeadingZero(numeral: (UInt(interval) % 3600) / 60)

        return "\(hours):\(mins)"
    }

    /**

        Add leading zeros to numbers where necessary

        - Parameter numeral: Number in question

        - Returns: string of two characters

    */
    static func addLeadingZero(numeral: UInt) -> String {
        return numeral < 10 ? "0\(numeral)" : "\(numeral)"
    }
}
