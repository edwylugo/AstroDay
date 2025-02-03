//
//  HomeCoordinator.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import UIKit

protocol HomeCoordinatorProtocol: Coordinator {
    func showHome()
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .home }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print("HomeCoordinator deinit")
    }

    func start() {
        showHome()
    }
    
    func showHome() {
        let viewModel = HomeViewModel(navigationDelegate: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension HomeCoordinator: HomeViewModelNavigationProtocol {
    func shouldOpenMovie(url: URL) {
        let videoVC = APODMovieViewController(videoURL: url)
        navigationController.present(videoVC, animated: true)
    }
    
    func shouldSettings() {
        let coordinator = SettingsCoordinator(navigationController)
        coordinator.start()
    }
    
    func shouldFavorite() {
        let coordinator = FavoriteCoordinator(navigationController)
        coordinator.start()
    }
}
