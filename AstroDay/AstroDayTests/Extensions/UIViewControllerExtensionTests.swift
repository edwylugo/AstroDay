//
//  UIViewControllerExtensionTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UIViewControllerExtensionTests: XCTestCase {

    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testShowAlertWithOKAction() {
        let expectation = self.expectation(description: "OK button tapped")
        
        let okHandler: () -> Void = {
            expectation.fulfill()
        }

        viewController.showAlert(title: "Test Title", message: "Test Message", okHandler: okHandler)
        
        okHandler()

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testShowAlertWithCancelAction() {
        let expectation = self.expectation(description: "Cancel button tapped")

        let cancelHandler: () -> Void = {
            expectation.fulfill()
        }

        viewController.showAlert(title: "Test Title", message: "Test Message", cancelTitle: "Cancel", cancelHandler: cancelHandler)
        
        cancelHandler()

        waitForExpectations(timeout: 1, handler: nil)
    }
}
