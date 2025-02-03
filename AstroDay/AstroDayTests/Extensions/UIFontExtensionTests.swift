//
//  UIFontExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UIFontExtensionTests: XCTestCase {
    func testFontSizeValues() {
        XCTAssertEqual(UIFont.Size.f1.value, 1.0, "Size f1 should be 1.0")
        XCTAssertEqual(UIFont.Size.f10.value, 10.0, "Size f10 should be 10.0")
        XCTAssertEqual(UIFont.Size.f30.value, 30.0, "Size f30 should be 30.0")
    }
    
    func testRobotoFontExistence() {
        let font = UIFont.roboto(type: .regular, size: .f16)
        XCTAssertNotNil(font, "Roboto-Regular should return a valid UIFont")
    }
    
    func testFallbackToSystemFont() {
        let font = UIFont.roboto(type: .regular, size: .f16)
        if UIFont(name: UIFont.Roboto.regular.rawValue, size: UIFont.Size.f16.value) == nil {
            XCTAssertEqual(font, UIFont.systemFont(ofSize: UIFont.Size.f16.value), "Should fall back to system font if Roboto is unavailable")
        }
    }
}
