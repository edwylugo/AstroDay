//
//  ConfigurableTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ConfigurableTests: XCTestCase {

    class TestCell: UITableViewCell, Configurable {
        typealias Configuration = String
        var configuredContent: String?

        func configure(content: String) {
            configuredContent = content
        }
    }

    func testConfigure() {
        let testCell = TestCell()
        let content = "Test Content"
        
        testCell.configure(content: content)
        
        XCTAssertEqual(testCell.configuredContent, content)
    }
}
