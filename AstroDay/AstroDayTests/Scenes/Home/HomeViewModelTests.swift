//
//  HomeViewModelTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class HomeViewModelTests: XCTestCase {

    var homeViewModel: HomeViewModel!
    var navigationDelegateMock: HomeViewModelNavigationProtocolMock!

    override func setUp() {
        super.setUp()
        navigationDelegateMock = HomeViewModelNavigationProtocolMock()
        homeViewModel = HomeViewModel(navigationDelegate: navigationDelegateMock)
    }

    override func tearDown() {
        homeViewModel = nil
        navigationDelegateMock = nil
        super.tearDown()
    }

    func testFetchAPODsDefault() {
        homeViewModel.fetchAPODsDefault()
        XCTAssertTrue(homeViewModel.isLoading.value)
        XCTAssertFalse(homeViewModel.isNotFound.value)
        XCTAssertEqual(homeViewModel.isError.value, "")
    }

    func testFetchAPODsSpecificDay() {
        let date = "2025-02-01"
        homeViewModel.fetchAPODsSpecificDay(date: date)
        XCTAssertTrue(homeViewModel.isLoading.value)
        XCTAssertFalse(homeViewModel.isNotFound.value)
        XCTAssertEqual(homeViewModel.isError.value, "")
    }

    func testShouldFavorite() {
        homeViewModel.shouldFavorite()
        XCTAssertTrue(navigationDelegateMock.shouldFavoriteCalled)
    }

    func testShouldSettings() {
        homeViewModel.shouldSettings()
        XCTAssertTrue(navigationDelegateMock.shouldSettingsCalled)
    }

    func testAddFavorite() {
        let apod = APODModel(title: "Test", explanation: String(), url: "https://example.com", mediaType: "image", date: String())
        let result = homeViewModel.addFavorite(apod)
        XCTAssertNotEqual(result, "Favorite added successfully")
    }

    func testShouldOpenMovie() {
        let apod = APODModel(title: "Test", explanation: String(), url: "https://example.com", mediaType: "video", date: String())
        homeViewModel.shouldOpenMovie(apod: apod)
        XCTAssertTrue(navigationDelegateMock.shouldOpenMovieCalled)
    }

    func testWsFinishedWithSuccess() {
        let sender = NSDictionary()
        homeViewModel.wsFinishedWithSuccess(sender: sender, status: .success)
        XCTAssertFalse(homeViewModel.isLoading.value)
        XCTAssertTrue(homeViewModel.isNotFound.value)
    }

    func testWsFinishedWithError() {
        let sender = NSDictionary()
        homeViewModel.wsFinishedWithError(sender: sender, error: "Error", status: .badRequest, code: 404)
        XCTAssertFalse(homeViewModel.isLoading.value)
        XCTAssertTrue(homeViewModel.isNotFound.value)
        XCTAssertEqual(homeViewModel.isError.value, "Error")
    }
}

class HomeViewModelNavigationProtocolMock: HomeViewModelNavigationProtocol {
    var shouldFavoriteCalled = false
    var shouldSettingsCalled = false
    var shouldOpenMovieCalled = false

    func shouldFavorite() {
        shouldFavoriteCalled = true
    }

    func shouldSettings() {
        shouldSettingsCalled = true
    }

    func shouldOpenMovie(url: URL) {
        shouldOpenMovieCalled = true
    }
}
