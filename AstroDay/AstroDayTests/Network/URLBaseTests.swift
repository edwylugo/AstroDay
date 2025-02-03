//
//  URLBaseTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class URLBaseTests: XCTestCase {

    func testBaseUrl() {
        let mockEnvironmentPlist = ["apodBaseUrl": "https://example.com"]
        saveMockEnvironmentPlist(mockEnvironmentPlist)

        let baseUrl = URLBase.baseUrl()

        XCTAssertEqual(baseUrl, "https://example.com")
    }

    func testApiKey() {
        let mockEnvironmentPlist = ["apodAPIKey": "mock-api-key"]
        saveMockEnvironmentPlist(mockEnvironmentPlist)

        let apiKey = URLBase.apiKey()

        XCTAssertEqual(apiKey, "mock-api-key")
    }

    private func saveMockEnvironmentPlist(_ mockPlist: [String: String]) {
        let fileManager = FileManager.default
        let environmentPlistPath = Bundle.main.bundlePath + "/environment.plist"
        let mockEnvironmentPlistURL = URL(fileURLWithPath: environmentPlistPath)
        NSDictionary(dictionary: mockPlist).write(to: mockEnvironmentPlistURL, atomically: true)
    }
}
