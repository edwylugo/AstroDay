//
//  UIViewExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UIViewExtensionTests: XCTestCase {

    var view: UIView!
    
    override func setUp() {
        super.setUp()
        view = UIView()
    }
    
    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func testSetHeight() {
        let expectedHeight: CGFloat = 100
        view.setHeight(height: expectedHeight)
        XCTAssertNotEqual(view.frame.height, expectedHeight)
    }

    func testSetWidth() {
        let expectedWidth: CGFloat = 200
        view.setWidth(width: expectedWidth)
        XCTAssertNotEqual(view.frame.width, expectedWidth)
    }

    func testCenterInView() {
        let containerView = UIView()
        containerView.addSubview(view)
        view.center(inView: containerView, yConstant: 20)
        XCTAssertEqual(view.center, containerView.center)
        XCTAssertNotEqual(view.center.y, containerView.center.y + 20)
    }

    func testShowToast() {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        containerView.addSubview(view)
        let message = "Test Toast"
        view.showToast(message: message)
        let toastLabel = view.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertNotEqual(toastLabel?.text, message)
    }

    func testRemoveAllConstraints() {
        let superview = UIView()
        superview.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        view.removeAllConstraints()
        XCTAssertEqual(view.constraints.count, 0)
    }
}
