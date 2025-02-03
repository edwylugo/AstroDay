//
//  StringsTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class StringsTests: XCTestCase {
    
    func test_nav_title_favorites() {
        let expected = "Favorites"
        XCTAssertEqual(Strings.nav_title_favorites, expected)
    }
    
    func test_nav_title_settings() {
        let expected = "Settings"
        XCTAssertEqual(Strings.nav_title_settings, expected)
    }
    
    func test_label_text_theme() {
        let expected = "Mode Dark/Light"
        XCTAssertEqual(Strings.label_text_theme, expected)
    }
    
    func test_text_no_favorite() {
        let expected = "No APODs have been added\nto your favorites"
        XCTAssertEqual(Strings.text_no_favorite, expected)
    }
    
    func test_text_no_found() {
        let expected = "No APODs have been found"
        XCTAssertEqual(Strings.text_no_found, expected)
    }
    
    func test_text_what_a_shame() {
        let expected = "What a shame!"
        XCTAssertEqual(Strings.text_what_a_shame, expected)
    }
    
    func test_button_text_closed() {
        let expected = "X"
        XCTAssertEqual(Strings.button_text_closed, expected)
    }
    
    func test_button_more() {
        let expected = "more"
        XCTAssertEqual(Strings.button_more, expected)
    }
    
    func test_button_hide() {
        let expected = "hide"
        XCTAssertEqual(Strings.button_hide, expected)
    }
    
    func test_text_toast_already_added() {
        let expected = "APOD has already been added to favorites."
        XCTAssertEqual(Strings.text_toast_already_added, expected)
    }
    
    func test_text_toast_successfully_added() {
        let expected = "APOD successfully added to favorites."
        XCTAssertEqual(Strings.text_toast_successfully_added, expected)
    }
    
    func test_text_toast_removed() {
        let expected = "APOD successfully removed."
        XCTAssertEqual(Strings.text_toast_removed, expected)
    }
    
    func test_text_toast_not_found() {
        let text = "Item"
        let expected = "Error: APOD with title \(text) not found."
        XCTAssertEqual(Strings.text_toast_not_found(text: text), expected)
    }
    
    func test_button_text_ok() {
        let expected = "OK"
        XCTAssertEqual(Strings.button_text_ok, expected)
    }
    
    func test_button_text_cancel() {
        let expected = "Cancel"
        XCTAssertEqual(Strings.button_text_cancel, expected)
    }
}
