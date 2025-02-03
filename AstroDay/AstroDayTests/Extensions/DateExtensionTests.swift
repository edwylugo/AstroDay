//
//  DateExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class DateExtensionTests: XCTestCase {
    func testFormattedAPODDate() {
        let dateComponents = DateComponents(year: 2024, month: 2, day: 1)
        let calendar = Calendar.current
        guard let testDate = calendar.date(from: dateComponents) else {
            XCTFail("Failed to create test date")
            return
        }
        
        let formattedDate = testDate.formattedAPODDate()
        XCTAssertEqual(formattedDate, "2024-02-01", "formattedAPODDate() should return the expected date format")
    }
}
