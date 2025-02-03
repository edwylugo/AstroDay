//
//  SettingsCoordinatorTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class SettingsCoordinatorTests: XCTestCase {

    var settingsCoordinator: SettingsCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        settingsCoordinator = SettingsCoordinator(navigationController)
    }

    override func tearDown() {
        settingsCoordinator = nil
        navigationController = nil
        super.tearDown()
    }

    func testStartShowsSettings() {
        settingsCoordinator.start()
        XCTAssertTrue(navigationController.topViewController is SettingsViewController)
    }

    func testShowSettingsPushesViewController() {
        settingsCoordinator.showSettings()
        XCTAssertTrue(navigationController.viewControllers.last is SettingsViewController)
    }

    func testShouldBack() {
        settingsCoordinator.start()
        let initialViewControllerCount = navigationController.viewControllers.count
        settingsCoordinator.shouldBack()
        let finalViewControllerCount = navigationController.viewControllers.count
        XCTAssertEqual(finalViewControllerCount, initialViewControllerCount - 0)
    }
}
