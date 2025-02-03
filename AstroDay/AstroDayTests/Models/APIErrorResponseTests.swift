//
//  APIErrorResponseTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class APIErrorResponseTests: XCTestCase {

    func testDecodingAPIErrorResponse() {
        let jsonString = """
        {
            "error": {
                "message": "Something went wrong",
                "code": "500"
            }
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let apiErrorResponse = try decoder.decode(APIErrorResponse.self, from: jsonData)
            
            XCTAssertEqual(apiErrorResponse.error.message, "Something went wrong")
            XCTAssertEqual(apiErrorResponse.error.code, "500")
        } catch {
            XCTFail("Failed to decode APIErrorResponse: \(error.localizedDescription)")
        }
    }

    func testEncodingAPIErrorResponse() {
        let error = APIError(message: "Something went wrong", code: "500")
        let apiErrorResponse = APIErrorResponse(error: error)
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(apiErrorResponse)
            
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            XCTAssertNotNil(jsonString)
            XCTAssertTrue(jsonString!.contains("\"message\":\"Something went wrong\""))
            XCTAssertTrue(jsonString!.contains("\"code\":\"500\""))
        } catch {
            XCTFail("Failed to encode APIErrorResponse: \(error.localizedDescription)")
        }
    }
}
