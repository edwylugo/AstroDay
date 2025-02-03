//
//  UIStackViewExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UIStackViewExtensionTests: XCTestCase {
    func testAddArrangedSubviews() {
        let stackView = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        
        stackView.addArrangedSubviews([view1, view2])
        
        XCTAssertTrue(stackView.arrangedSubviews.contains(view1), "StackView should contain view1")
        XCTAssertTrue(stackView.arrangedSubviews.contains(view2), "StackView should contain view2")
    }
    
    func testRemoveFull() {
        let stackView = UIStackView()
        let view = UIView()
        stackView.addArrangedSubview(view)
        
        stackView.removeFull(view: view)
        
        XCTAssertFalse(stackView.arrangedSubviews.contains(view), "StackView should not contain the removed view")
        XCTAssertNil(view.superview, "Removed view should have no superview")
    }
    
    func testRemoveFullAllArrangedSubviews() {
        let stackView = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        stackView.addArrangedSubviews([view1, view2])
        
        stackView.removeFullAllArrangedSubviews()
        
        XCTAssertTrue(stackView.arrangedSubviews.isEmpty, "StackView should have no arranged subviews left")
    }
}
