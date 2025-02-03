//
//  CoordinatorProtocol.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import UIKit

protocol RootViewControllerProvider: AnyObject {
    var rootViewController: UINavigationController { get }
}

typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    func start()
    func finish()
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter {
            $0 !== childCoordinator
        }
    }
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func backScreen() {
        navigationController.popViewController(animated: true)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case home, favorite, settings
}
