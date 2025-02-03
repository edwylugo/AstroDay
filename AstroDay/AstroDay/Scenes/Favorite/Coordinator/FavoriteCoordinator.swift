//
//  FavoriteCoordinator.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

protocol FavoriteCoordinatorProtocol: Coordinator {
    func showFavorite()
}

final class FavoriteCoordinator: FavoriteCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .favorite }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print("FavoriteCoordinator deinit")
    }

    func start() {
        showFavorite()
    }
    
    func showFavorite() {
        let viewModel = FavoriteViewModel(navigationDelegate: self)
        let viewController = FavoriteViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension FavoriteCoordinator: FavoriteViewModelNavigationProtocol {
    func shouldOpenMovie(url: URL) {
        let videoVC = APODMovieViewController(videoURL: url)
        navigationController.present(videoVC, animated: true)
    }
    
    func shouldBack() {
        backScreen()
    }
}
