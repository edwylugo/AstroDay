//
//  DatePickerViewControllerTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class DatePickerViewControllerTests: XCTestCase {

    var datePickerViewController: DatePickerViewController!

    override func setUp() {
        super.setUp()
        datePickerViewController = DatePickerViewController()
        datePickerViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        datePickerViewController = nil
        super.tearDown()
    }

    func testDatePickerInitialization() {
        XCTAssertNotNil(datePickerViewController.datePicker)
        XCTAssertEqual(datePickerViewController.datePicker.datePickerMode, .date)
        XCTAssertEqual(datePickerViewController.datePicker.preferredDatePickerStyle, .wheels)
        XCTAssertTrue(datePickerViewController.datePicker.maximumDate! <= Date())
    }

    func testSelectButtonAction() {
        let expect = expectation(description: "Date selected callback should be called")
        datePickerViewController.onDateSelected = { selectedDate in
            XCTAssertNotNil(selectedDate)
            XCTAssertTrue(selectedDate.count > 0)
            expect.fulfill()
        }

        datePickerViewController.selectDate()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testCancelButtonAction() {
        let initialDismissCount = self.datePickerViewController.navigationController?.viewControllers.count ?? 0
        datePickerViewController.dismissModal()
        XCTAssertNotEqual(self.datePickerViewController.navigationController?.viewControllers.count, initialDismissCount - 1)
    }

    func testStackViewSubviews() {
        XCTAssertEqual(datePickerViewController.stackView.arrangedSubviews.count, 3)
        XCTAssertTrue(datePickerViewController.stackView.arrangedSubviews.contains(datePickerViewController.datePicker))
        XCTAssertTrue(datePickerViewController.stackView.arrangedSubviews.contains(datePickerViewController.selectButton))
        XCTAssertTrue(datePickerViewController.stackView.arrangedSubviews.contains(datePickerViewController.cancelButton))
    }
}
