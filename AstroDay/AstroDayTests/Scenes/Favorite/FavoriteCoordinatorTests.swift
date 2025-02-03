//
//  FavoriteCoordinatorTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class FavoriteCoordinatorTests: XCTestCase {

    var coordinator: FavoriteCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        coordinator = FavoriteCoordinator(navigationController)
    }

    override func tearDown() {
        coordinator = nil
        navigationController = nil
        super.tearDown()
    }

    func testCoordinatorStart() {
        coordinator.start()
        
        XCTAssertTrue(navigationController.viewControllers.first is FavoriteViewController)
    }

    func testShowFavorite() {
        coordinator.showFavorite()
        
        XCTAssertTrue(navigationController.viewControllers.first is FavoriteViewController)
    }

    func testShouldOpenMovie() {
        let url = URL(string: "https://example.com")!
        coordinator.shouldOpenMovie(url: url)
        
        XCTAssertFalse(navigationController.presentedViewController is APODMovieViewController)
    }
    
    func testShouldBack() {
        let initialViewControllersCount = navigationController.viewControllers.count
        coordinator.shouldBack()
        
        XCTAssertNotEqual(navigationController.viewControllers.count, initialViewControllersCount - 1)
    }
}
