//
//  SettingsViewModelTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class SettingsViewModelTests: XCTestCase {

    var viewModel: SettingsViewModel!
    var mockNavigationDelegate: MockNavigationDelegate!
    
    override func setUp() {
        super.setUp()
        mockNavigationDelegate = MockNavigationDelegate()
        viewModel = SettingsViewModel(navigationDelegate: mockNavigationDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockNavigationDelegate = nil
        super.tearDown()
    }

    func test_shouldBack_callsNavigationDelegate() {
        viewModel.shouldBack()
        XCTAssertTrue(mockNavigationDelegate.didCallShouldBack)
    }

    func test_isLoading_initialValue() {
        XCTAssertFalse(viewModel.isLoading.value)
    }

    func test_isError_initialValue() {
        XCTAssertNotNil(viewModel.isError.value)
    }
}

class MockNavigationDelegate: SettingsViewModelNavigationProtocol {
    var didCallShouldBack = false
    
    func shouldBack() {
        didCallShouldBack = true
    }
}
