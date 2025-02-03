//
//  ViewModelTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ViewModelTests: XCTestCase {

    func testIsLoadingBinding() {
        let viewModel = ViewModel()
        var loadingState: Bool?

        viewModel.isLoading.bind { value in
            loadingState = value
        }

        viewModel.isLoading.value = true

        XCTAssertEqual(loadingState, true)
    }

    func testIsErrorBinding() {
        let viewModel = ViewModel()
        var errorState: String?

        viewModel.isError.bind { value in
            errorState = value
        }

        viewModel.isError.value = "An error occurred"

        XCTAssertEqual(errorState, "An error occurred")
    }
}

class ViewModel: ViewModelProtocol {
    var isLoading: Observable<Bool> = Observable(false)
    var isError: Observable<String?> = Observable("")
}
