//
//  ThemeManagerTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ThemeManagerTests: XCTestCase {
    
    func testToggleTheme() {
        let themeManager = ThemeManager.shared
        
        themeManager.toggleTheme(isDarkMode: true)
        XCTAssertEqual(themeManager.currentTheme, .dark)
        
        themeManager.toggleTheme(isDarkMode: false)
        XCTAssertEqual(themeManager.currentTheme, .light)
    }
    
    func testThemeNotification() {
        let expectation = XCTestExpectation(description: "Theme change notification received")
        let themeManager = ThemeManager.shared
        
        let delegate = TestThemeManagerDelegate(expectation: expectation)
        themeManager.register(delegate)
        
        themeManager.toggleTheme(isDarkMode: true)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

class TestThemeManagerDelegate: NSObject, ThemeManagerDelegate {
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func themeDidChange(to theme: Int) {
        XCTAssertNotEqual(theme, Theme.dark.rawValue)
        expectation.fulfill()
    }
}
