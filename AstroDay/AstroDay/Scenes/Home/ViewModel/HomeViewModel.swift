//
//  HomeViewModel.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import Foundation

// MARK: - HomeViewModelNavigationProtocol - Use in Coordinator
protocol HomeViewModelNavigationProtocol: AnyObject {
    func shouldFavorite()
    func shouldSettings()
    func shouldOpenMovie(url: URL)
}

// MARK: - HomeProtocol - Protocol definition Use in Controller
protocol HomeViewModelProtocol: ViewModelProtocol {
    var isLoading: Observable<Bool> { get }
    var isError: Observable<String?> { get }
    var isNotFound: Observable<Bool> { get }
    var dataAPODModel: Observable<[APODModel]> { get }
    func fetchAPODsSpecificDay(date: String)
    func shouldFavorite()
    func shouldSettings()
    func addFavorite(_ apod: APODModel) -> String
    func shouldOpenMovie(apod: APODModel)
}

// MARK: - HomeViewModel
class HomeViewModel: HomeViewModelProtocol {
    private var navigationDelegate: HomeViewModelNavigationProtocol
    var isLoading: Observable<Bool>
    var isError: Observable<String?>
    var isNotFound: Observable<Bool>
    var dataAPODModel: Observable<[APODModel]>
    
    init(navigationDelegate: HomeViewModelNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
        self.isLoading = Observable(false)
        self.isError = Observable("")
        self.isNotFound = Observable(false)
        self.dataAPODModel = Observable([])
        self.fetchAPODsDefault()
    }
    
    func fetchAPODsDefault() {
        self.isLoading.value = true
        self.isNotFound.value = false
        self.isError.value = ""
        let service = APODService()
        service.delegate = self
        service.fetchAPOD()
    }
    
    func fetchAPODsSpecificDay(date: String){
        self.dataAPODModel.value = []
        self.isLoading.value = true
        self.isNotFound.value = false
        self.isError.value = ""
        let service = APODService()
        service.delegate = self
        service.fetchAPOD(date: date)
    }
    
    func shouldFavorite() {
        navigationDelegate.shouldFavorite()
    }
    
    func shouldSettings() {
        navigationDelegate.shouldSettings()
    }
    
    func addFavorite(_ apod: APODModel) -> String {
        let apodManager = APODDataManager()
        return apodManager.insertAPOD(apod)
    }
    
    func shouldOpenMovie(apod: APODModel) {
        if apod.mediaType == "video", let videoURL = URL(string: apod.url) {
            navigationDelegate.shouldOpenMovie(url: videoURL)
        }
    }
}

extension HomeViewModel: WsDelegate {
    func wsFinishedWithSuccess(sender: NSDictionary, status: WsStatus) {
        self.isLoading.value = false
        if status == .success {
            do {
                let apods = try APODMapper.map(json: sender)
                self.dataAPODModel.value = apods
                if apods.count == 0 {
                    self.isNotFound.value = true
                }
                debugPrint("Dados mapeados com sucesso: \(apods.count) itens")
            } catch {
                self.isNotFound.value = true
                debugPrint("Erro ao mapear dados: \(error.localizedDescription)")
            }
        } else {
            if self.dataAPODModel.value.isEmpty {
                self.isNotFound.value = true
            }
        }
    }
    
    func wsFinishedWithError(sender: NSDictionary, error: String, status: WsStatus, code: Int) {
        self.isLoading.value = false
        self.isNotFound.value = true
        self.isError.value = error
    }
}
