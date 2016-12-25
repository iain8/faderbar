//
//  FaderBarTests.swift
//  FaderBarTests
//
//  Created by iain on 03/12/16.
//  Copyright © 2016 iain. All rights reserved.
//

import XCTest
@testable import FaderBar

class FaderBarTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    /**

        Test adding leading zeros to numbers

    */
    func testLeadingZeros() {
        let lessThanTen = UInt(5)

        var padded = TimeHelper.addLeadingZero(numeral: lessThanTen)

        XCTAssertEqual(padded, "05")

        let moreThanTen = UInt(14)

        padded = TimeHelper.addLeadingZero(numeral: moreThanTen)

        XCTAssertEqual(padded, "14")
    }
}
