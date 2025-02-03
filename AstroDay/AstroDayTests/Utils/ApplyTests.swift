//
//  ApplyTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ApplyTests: XCTestCase {
    
    func testApply() {
        let jsonDecoder = JSONDecoder().apply { decoder in
            decoder.dateDecodingStrategy = .iso8601
        }
        
        let jsonEncoder = JSONEncoder().apply { encoder in
            encoder.outputFormatting = .prettyPrinted
        }
        
        XCTAssertEqual(jsonEncoder.outputFormatting, .prettyPrinted)
    }
}
