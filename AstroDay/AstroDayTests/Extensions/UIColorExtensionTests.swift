//
//  UIColorExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UIColorExtensionTests: XCTestCase {
    func testRGBInitializer() {
        let color = UIColor(red: 255, green: 0, blue: 0)
        XCTAssertEqual(color, UIColor.red, "UIColor(red:green:blue:) should correctly initialize a red color")
    }
    
    func testRGBHexInitializer() {
        let color = UIColor(rgb: 0xFF0000)
        XCTAssertEqual(color, UIColor.red, "UIColor(rgb:) should correctly initialize a red color")
    }
    
    func testSupportedColorLightMode() {
        if #available(iOS 13.0, *) {
            let color = UIColor.themeDefault
            let resolvedColor = color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
            XCTAssertEqual(resolvedColor, UIColor(rgb: 0xFFFFFF), "themeDefault should be white in light mode")
        }
    }
    
    func testSupportedColorDarkMode() {
        if #available(iOS 13.0, *) {
            let color = UIColor.themeDefault
            let resolvedColor = color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
            XCTAssertEqual(resolvedColor, UIColor(rgb: 0x000000), "themeDefault should be black in dark mode")
        }
    }
}
