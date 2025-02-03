//
//  FavoriteViewModel.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import Foundation

// MARK: - FavoriteViewModelNavigationProtocol - Use in Coordinator
protocol FavoriteViewModelNavigationProtocol: AnyObject {
    func shouldBack()
    func shouldOpenMovie(url: URL)
}

// MARK: - FavoriteProtocol - Protocol definition Use in Controller
protocol FavoriteViewModelProtocol: ViewModelProtocol {
    var isLoading: Observable<Bool> { get }
    var isError: Observable<String?> { get }
    var dataAPODModel: Observable<[APODModel]> { get }
    func shouldBack()
    func getFavorites()
    func removeFavorite(_ apod: APODModel) -> String
    func shouldOpenMovie(apod: APODModel)
}

// MARK: - FavoriteViewModel
class FavoriteViewModel: FavoriteViewModelProtocol {
    private var navigationDelegate: FavoriteViewModelNavigationProtocol
    var isLoading: Observable<Bool>
    var isError: Observable<String?>
    var dataAPODModel: Observable<[APODModel]>
    
    init(navigationDelegate: FavoriteViewModelNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
        self.isLoading = Observable(false)
        self.isError = Observable("")
        self.dataAPODModel = Observable([])
        self.getFavorites()
    }
    
    func shouldBack() {
        navigationDelegate.shouldBack()
    }
    
    func getFavorites() {
        dataAPODModel.value = APODDataManager().readAPODs()
    }
     
    func removeFavorite(_ apod: APODModel) -> String {
        let apodManager = APODDataManager()
        return apodManager.deleteAPOD(title: apod.title)
    }
    
    func shouldOpenMovie(apod: APODModel) {
        if apod.mediaType == "video", let videoURL = URL(string: apod.url) {
            navigationDelegate.shouldOpenMovie(url: videoURL)
        }
    }
}
