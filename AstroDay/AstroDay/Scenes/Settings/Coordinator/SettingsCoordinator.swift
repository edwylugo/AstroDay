//
//  SettingsCoordinator.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

protocol SettingsCoordinatorProtocol: Coordinator {
    func showSettings()
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .settings }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print("SettingsCoordinator deinit")
    }

    func start() {
        showSettings()
    }
    
    func showSettings() {
        let viewModel = SettingsViewModel(navigationDelegate: self)
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsViewModelNavigationProtocol {
    func shouldBack() {
        backScreen()
    }
}
