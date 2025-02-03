//
//  WsStatusTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class WsStatusTests: XCTestCase {

    func testCodeStatus() {
        let statusCases: [(WsStatus, Int)] = [
            (.success, 200),
            (.created, 201),
            (.accepted, 202),
            (.noContent, 204),
            (.notModified, 304),
            (.badRequest, 400),
            (.unauthorized, 401),
            (.forbidden, 403),
            (.notFound, 404),
            (.methodNotAllowed, 405),
            (.requestTimeOut, 408),
            (.internalServerError, 500),
            (.noInternet, -1),
            (.conflict, 409),
            (.undefined, 99),
            (.tooManyRequests, 429),
            (.noData, 550)
        ]
        
        for (status, expectedCode) in statusCases {
            XCTAssertEqual(status.codeStatus, expectedCode, "Code status for \(status.rawValue) should be \(expectedCode)")
        }
    }

    func testAllWsStatusValues() {
        let allStatuses = WsStatus.allCases
        let expectedCount = 17
        XCTAssertEqual(allStatuses.count, expectedCount, "There should be \(expectedCount) WsStatus cases")
    }
}
