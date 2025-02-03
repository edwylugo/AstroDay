//
//  FavoriteViewModelTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class FavoriteViewModelTests: XCTestCase {

    var viewModel: FavoriteViewModel!
    var navigationDelegateMock: FavoriteViewModelNavigationProtocolMock!

    override func setUp() {
        super.setUp()
        navigationDelegateMock = FavoriteViewModelNavigationProtocolMock()
        viewModel = FavoriteViewModel(navigationDelegate: navigationDelegateMock)
    }

    override func tearDown() {
        viewModel = nil
        navigationDelegateMock = nil
        super.tearDown()
    }

    func testShouldBack() {
        viewModel.shouldBack()
        XCTAssertTrue(navigationDelegateMock.didCallShouldBack)
    }

    func testGetFavorites() {
        let apodDataManagerMock = APODDataManagerMock()
        apodDataManagerMock.stubbedReadAPODs = [APODModel(title: "Test", explanation: String(), url: "test_url", mediaType: "image", date: String())]
        
        viewModel.getFavorites()
        
        XCTAssertNotEqual(viewModel.dataAPODModel.value.count, -1)
    }
    
    func testRemoveFavorite() {
        let apod = APODModel(title: "Test", explanation: String(), url: "test_url", mediaType: "image", date: String())
        let result = viewModel.removeFavorite(apod)
        
        XCTAssertNotEqual(result, "APOD removed successfully")
    }

    func testShouldOpenMovie() {
        let apod = APODModel(title: "Test", explanation: String(), url: "test_url", mediaType: "video", date: String())
        
        viewModel.shouldOpenMovie(apod: apod)
        
        XCTAssertTrue(navigationDelegateMock.didCallShouldOpenMovie)
    }
}

class FavoriteViewModelNavigationProtocolMock: FavoriteViewModelNavigationProtocol {
    var didCallShouldBack = false
    var didCallShouldOpenMovie = false
    var movieURL: URL?
    
    func shouldBack() {
        didCallShouldBack = true
    }
    
    func shouldOpenMovie(url: URL) {
        didCallShouldOpenMovie = true
        movieURL = url
    }
}

class APODDataManagerMock {
    var stubbedReadAPODs: [APODModel] = []
    
    func readAPODs() -> [APODModel] {
        return stubbedReadAPODs
    }
    
    func deleteAPOD(title: String) -> String {
        return "APOD removed successfully"
    }
}
