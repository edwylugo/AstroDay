//
//  HomeCoordinatorTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class HomeCoordinatorTests: XCTestCase {

    var homeCoordinator: HomeCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController)
    }

    override func tearDown() {
        homeCoordinator = nil
        navigationController = nil
        super.tearDown()
    }

    func testStart() {
        homeCoordinator.start()
        XCTAssertTrue(navigationController.viewControllers.first is HomeViewController)
    }

    func testShowHome() {
        homeCoordinator.showHome()
        XCTAssertTrue(navigationController.viewControllers.first is HomeViewController)
    }
    
    func testShouldOpenMovie() {
        let url = URL(string: "https://example.com")!
        let videoVC = APODMovieViewController(videoURL: url)
        
        homeCoordinator.shouldOpenMovie(url: url)
        
        XCTAssertFalse(navigationController.topViewController is APODMovieViewController)
    }
    
    func testShouldSettings() {
        homeCoordinator.shouldSettings()
        XCTAssertTrue(navigationController.topViewController is SettingsViewController)
    }
    
    func testShouldFavorite() {
        homeCoordinator.shouldFavorite()
        XCTAssertTrue(navigationController.topViewController is FavoriteViewController)
    }
}
