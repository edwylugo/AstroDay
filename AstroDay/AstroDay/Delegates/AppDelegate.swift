//
//  AppDelegate.swift
//  AstroDay
//
//  Created by Edwy Lugo on 29/01/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.roboto(type: .medium, size: .f12)]

        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .white
        navigationBar.barStyle = .default
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.isHidden = true
        navigationBar.scrollEdgeAppearance =  navigationBar.standardAppearance

        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navController: UINavigationController = .init()
        navController.modalPresentationStyle = .fullScreen
        navController.navigationItem.hidesBackButton = true
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        coordinator = HomeCoordinator.init(navController)
        coordinator?.start()
        
        return true
    }
}
