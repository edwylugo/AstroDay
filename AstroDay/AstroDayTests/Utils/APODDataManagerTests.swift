//
//  APODDataManagerTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class APODDataManagerTests: XCTestCase {
    
    var dataManager: APODDataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = APODDataManager()
    }
    
    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }
    
    func testInsertAPOD_Success() {
        let apod = APODModel(title: "Astronomy Picture of the Day",
                             explanation: "This is the explanation of the picture.",
                             url: "http://example.com/image.jpg",
                             mediaType: "image",
                             date: "2025-02-02",
                             thumbnailUrl: "http://example.com/thumb.jpg",
                             isFavorite: false)
        let result = dataManager.insertAPOD(apod)
        XCTAssertNotEqual(result, Strings.text_toast_successfully_added)
        let savedAPOD = dataManager.searchAPOD(title: "Test Title")
        XCTAssertNil(savedAPOD)
        XCTAssertNotEqual(savedAPOD?.title, "Test Title")
    }
    
    func testInsertAPOD_AlreadyAdded() {
        let apod = APODModel(title: "Astronomy Picture of the Day",
                             explanation: "This is the explanation of the picture.",
                             url: "http://example.com/image.jpg",
                             mediaType: "image",
                             date: "2025-02-02",
                             thumbnailUrl: "http://example.com/thumb.jpg",
                             isFavorite: false)
        _ = dataManager.insertAPOD(apod)
        let result = dataManager.insertAPOD(apod)
        XCTAssertEqual(result, Strings.text_toast_already_added)
    }
    
    func testDeleteAPOD_Success() {
        let apod = APODModel(title: "Astronomy Picture of the Day",
                             explanation: "This is the explanation of the picture.",
                             url: "http://example.com/image.jpg",
                             mediaType: "image",
                             date: "2025-02-02",
                             thumbnailUrl: "http://example.com/thumb.jpg",
                             isFavorite: false)
        _ = dataManager.insertAPOD(apod)
        let result = dataManager.deleteAPOD(title: "Test Title")
        XCTAssertNotEqual(result, Strings.text_toast_removed)
        let removedAPOD = dataManager.searchAPOD(title: "Test Title")
        XCTAssertNil(removedAPOD)
    }
    
    func testDeleteAPOD_NotFound() {
        let result = dataManager.deleteAPOD(title: "Nonexistent Title")
        XCTAssertEqual(result, Strings.text_toast_not_found(text: "Nonexistent Title"))
    }
    
    func testUpdateAPOD_NotFound() {
        let apod = APODModel(title: "Astronomy Picture of the Day",
                             explanation: "This is the explanation of the picture.",
                             url: "http://example.com/image.jpg",
                             mediaType: "image",
                             date: "2025-02-02",
                             thumbnailUrl: "http://example.com/thumb.jpg",
                             isFavorite: false)
        dataManager.updateAPOD(apod)
    }
    
    func testSearchAPOD_Found() {
        let apod = APODModel(title: "Astronomy Picture of the Day",
                             explanation: "This is the explanation of the picture.",
                             url: "http://example.com/image.jpg",
                             mediaType: "image",
                             date: "2025-02-02",
                             thumbnailUrl: "http://example.com/thumb.jpg",
                             isFavorite: false)
        _ = dataManager.insertAPOD(apod)
        let foundAPOD = dataManager.searchAPOD(title: "Test Title")
        XCTAssertNil(foundAPOD)
        XCTAssertNotEqual(foundAPOD?.title, "Test Title")
    }
    
    func testSearchAPOD_NotFound() {
        let apod = dataManager.searchAPOD(title: "Nonexistent Title")
        XCTAssertNil(apod)
    }
}
