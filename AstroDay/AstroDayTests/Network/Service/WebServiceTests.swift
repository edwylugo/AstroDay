//
//  WebServiceTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class WebServiceTests: XCTestCase {
    
    var webService: WebService!
    var mockDelegate: MockWsDelegate!

    override func setUp() {
        super.setUp()
        webService = WebService()
        mockDelegate = MockWsDelegate()
        webService.delegate = mockDelegate
    }

    override func tearDown() {
        webService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testHandleSuccess() {
        let mockJson: NSDictionary = [
            "result": [
                [
                    "title": "Astronomy Picture",
                    "url": "http://example.com/image.jpg",
                    "media_type": "image",
                    "date": "2025-01-01"
                ]
            ]
        ]
        
        webService.handleSuccess(jsonResult: mockJson)

        XCTAssertFalse(mockDelegate.didFinishWithSuccess)
    }

    func testHandleError() {
        let error = NSError(domain: "com.test", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        webService.handleError(error: error, response: nil)
        
        XCTAssertTrue(mockDelegate.didFinishWithError)
        XCTAssertEqual(mockDelegate.errorMessage, "No internet connection")
    }

    func testParseAPIError() {
        let errorResponse: NSDictionary = [
            "error": [
                "message": "Bad request",
                "code": "400"
            ]
        ]
        
        let apiErrorResponse = webService.parseAPIError(from: errorResponse)
        
        XCTAssertNotNil(apiErrorResponse)
        XCTAssertEqual(apiErrorResponse?.error.message, "Bad request")
        XCTAssertEqual(apiErrorResponse?.error.code, "400")
    }

    func testGetRequest() {
        let mockURL = "https://example.com/api"
        webService.get(url: mockURL)

        XCTAssertEqual(webService.lastMethod, "GET")
        XCTAssertEqual(webService.lastUrl, mockURL)
    }
    
    func testHandleNoDataResponse() {
        webService.handleResponse(data: nil, response: nil, error: nil)
        
        XCTAssertFalse(mockDelegate.didFinishWithError)
        XCTAssertNotEqual(mockDelegate.errorMessage, "No data received")
    }
}

class MockWsDelegate: WsDelegate {
    var didFinishWithSuccess = false
    var didFinishWithError = false
    var errorMessage: String?
    
    func wsFinishedWithSuccess(sender: NSDictionary, status: WsStatus) {
        didFinishWithSuccess = true
    }

    func wsFinishedWithError(sender: NSDictionary, error: String, status: WsStatus, code: Int) {
        didFinishWithError = true
        errorMessage = error
    }
}
