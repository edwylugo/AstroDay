//
//  APODLoading.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import Foundation
import UIKit

final class APODLoading: NSObject {
    
    static let shared = APODLoading()
    private var loadingView = APODLoadingView()
    
    override init() {
        super.init()
        
        guard let window = mainWindow() else { return }
        loadingView.frame = window.bounds
        window.addSubview(loadingView)
    }
    
    func show() {
        loadingView.loading?.play()
        loadingView.isHidden = false
        loadingView.backgroundColor = .clear
        guard let window = mainWindow() else { return }
        window.bringSubviewToFront(loadingView)
    }
    
    func hide() {
        loadingView.isHidden = true
        loadingView.loading?.stop()
    }
    
    private func mainWindow() -> UIWindow? {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return nil}
        return app.window
    }
}
