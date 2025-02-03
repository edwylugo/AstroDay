//
//  SettingsViewModel.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import Foundation

// MARK: - SettingsViewModelNavigationProtocol - Use in Coordinator
protocol SettingsViewModelNavigationProtocol: AnyObject {
    func shouldBack()
}

// MARK: - SettingsProtocol - Protocol definition Use in Controller
protocol SettingsViewModelProtocol: ViewModelProtocol {
    var isLoading: Observable<Bool> { get }
    var isError: Observable<String?> { get }
    func shouldBack()
}

// MARK: - SettingsViewModel
class SettingsViewModel: SettingsViewModelProtocol {
    private var navigationDelegate: SettingsViewModelNavigationProtocol
    var isLoading: Observable<Bool>
    var isError: Observable<String?>
    
    init(navigationDelegate: SettingsViewModelNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
        self.isLoading = Observable(false)
        self.isError = Observable("")
    }
    
    func shouldBack() {
        navigationDelegate.shouldBack()
    }
}
