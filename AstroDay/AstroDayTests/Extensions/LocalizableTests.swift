//
//  LocalizableTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class LocalizableTests: XCTestCase {
    func testLocalizedString() {
        let key = "hello_key"
        let expectedValue = "hello_key"
        
        UserDefaults.standard.set([key: expectedValue], forKey: "AppleLanguages")
        
        XCTAssertEqual(key.localized, expectedValue, "Localized string should match expected value")
    }
    
    func testLocalizedStringWithArguments() {
        let key = "greeting_key"
        let format = "Hello, %@!"
        let name = "Kate"
        let expectedValue = "greeting_key"
        
        UserDefaults.standard.set([key: format], forKey: "AppleLanguages")
        
        XCTAssertEqual(key.localized(with: name), expectedValue, "Localized string with argument should match expected value")
    }
}
