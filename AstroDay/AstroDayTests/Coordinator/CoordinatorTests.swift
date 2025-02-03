//
//  CoordinatorTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class MockFinishDelegate: CoordinatorFinishDelegate {
    var didFinishCalled = false
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        didFinishCalled = true
    }
}

class MockCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .home
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
}

final class CoordinatorTests: XCTestCase {
    var navigationController: UINavigationController!
    var coordinator: MockCoordinator!
    var finishDelegate: MockFinishDelegate!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        coordinator = MockCoordinator(navigationController)
        finishDelegate = MockFinishDelegate()
        coordinator.finishDelegate = finishDelegate
    }
    
    override func tearDown() {
        navigationController = nil
        coordinator = nil
        finishDelegate = nil
        super.tearDown()
    }
    
    func testAddChildCoordinator() {
        let childCoordinator = MockCoordinator(navigationController)
        coordinator.addChildCoordinator(childCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }
    
    func testRemoveChildCoordinator() {
        let childCoordinator = MockCoordinator(navigationController)
        coordinator.addChildCoordinator(childCoordinator)
        coordinator.removeChildCoordinator(childCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
    
    func testFinish() {
        coordinator.finish()
        XCTAssertTrue(finishDelegate.didFinishCalled)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
    
    func testBackScreen() {
        let viewController = UIViewController()
        navigationController.pushViewController(viewController, animated: false)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        
        coordinator.backScreen()
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
}
