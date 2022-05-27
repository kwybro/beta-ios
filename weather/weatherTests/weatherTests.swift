//
//  weatherTests.swift
//  weatherTests
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import XCTest
@testable import weather

class WeatherTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testEpochToHourHelper() {
        // Given
        let epoch: Double = 1653665067

        // When
        let hour = Helpers.epochToHour(epoch)

        // Then
        XCTAssertEqual(hour, "11 AM")
    }

    func testEpochToDateHelper() {
        // Given
        let epoch: Double = 1653665067

        // When
        let date = Helpers.epochToDate(epoch)

        // Then
        XCTAssertEqual(date, "May 27, 2022 at 11:24 AM")
    }

    func testIsTimeValidHelper_true() {
        // Given
        let epoch: Double = 1653665067

        // When
        let isTimeValid = Helpers.isTimeValid(epoch)

        // Then
        XCTAssertTrue(isTimeValid)
    }

    func testIsTimeValidHelper_false() {
        // Given
        let epoch: Double = 1653661000

        // When
        let isTimeValid = Helpers.isTimeValid(epoch)

        // Then
        XCTAssertFalse(isTimeValid)
    }
}
