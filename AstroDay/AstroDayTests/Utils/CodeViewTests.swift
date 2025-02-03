//
//  CodeViewTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class CodeViewTests: XCTestCase {
    
    class TestView: UIView, CodeView {
        var hierarchyBuilt = false
        var constraintsSetup = false
        var additionalConfigured = false
        
        func buildViewHierarchy() {
            hierarchyBuilt = true
        }
        
        func setupConstraints() {
            constraintsSetup = true
        }
        
        func setupAdditionalConfiguration() {
            additionalConfigured = true
        }
    }

    func testSetupViews() {
        let testView = TestView()
        
        testView.setupViews()
        
        XCTAssertTrue(testView.hierarchyBuilt)
        XCTAssertTrue(testView.constraintsSetup)
        XCTAssertTrue(testView.additionalConfigured)
    }
}
