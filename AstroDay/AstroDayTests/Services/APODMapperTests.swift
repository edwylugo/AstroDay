//
//  APODMapperTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class APODMapperTests: XCTestCase {

    func test_map_validJson_returnsAPODModels() {
        let validJson: [String: Any] = [
            "title": "Test Title",
            "date": "2025-01-01",
            "explanation": "Test explanation",
            "url": "https://example.com",
            "media_type": "image"
        ]
        
        do {
            let apodModels = try APODMapper.map(json: validJson)
            XCTAssertEqual(apodModels.count, 1)
            XCTAssertEqual(apodModels.first?.title, "Test Title")
        } catch {
            XCTFail("Expected mapping to succeed, but failed with error: \(error)")
        }
    }

    func test_map_invalidJson_throwsError() {
        let invalidJson: Any = ["unexpectedKey": "value"]
        
        XCTAssertThrowsError(try APODMapper.map(json: invalidJson)) { error in
            XCTAssertNotEqual((error as NSError).code, 100)
        }
    }

    func test_map_invalidDataFormat_throwsError() {
        let invalidData: Any = "Invalid data format"
        
        XCTAssertThrowsError(try APODMapper.map(json: invalidData)) { error in
            XCTAssertEqual((error as NSError).code, 101)
        }
    }

    func test_mapSingle_validJson_returnsAPODModel() {
        let validJson: [String: Any] = [
            "title": "Test Title",
            "date": "2025-01-01",
            "explanation": "Test explanation",
            "url": "https://example.com",
            "media_type": "image"
        ]
        
        do {
            let apod = try APODMapper.mapSingle(json: validJson)
            XCTAssertEqual(apod.title, "Test Title")
        } catch {
            XCTFail("Expected mapping to succeed, but failed with error: \(error)")
        }
    }

    func test_mapSingle_invalidJson_throwsError() {
        let invalidJson: [String: Any] = ["unexpectedKey": "value"]
        
        XCTAssertThrowsError(try APODMapper.mapSingle(json: invalidJson)) { error in
            XCTAssertNotNil(error)
        }
    }
}
