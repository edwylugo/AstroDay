//
//  ThemeManager.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

@objc protocol ThemeManagerDelegate: AnyObject {
    @objc func themeDidChange(to theme: Int)
}

enum Theme: Int {
    case light = 0
    case dark = 1
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        return self == .dark ? .dark : .light
    }
}

final class ThemeManager {
    
    static let shared = ThemeManager()
    
    private(set) var currentTheme: Theme {
        didSet {
            notifyThemeChange()
        }
    }
    
    private init() {
        if UserDefaults.standard.object(forKey: "isDarkMode") == nil {
            let prefersDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
            UserDefaults.standard.set(prefersDarkMode, forKey: "isDarkMode")
        }
        
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self.currentTheme = isDarkMode ? .dark : .light
    }
    
    func toggleTheme(isDarkMode: Bool) {
        currentTheme = isDarkMode ? .dark : .light
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
    
    func register(_ delegate: ThemeManagerDelegate) {
        NotificationCenter.default.addObserver(delegate, selector: #selector(ThemeManagerDelegate.themeDidChange(to:)), name: .themeDidChange, object: nil)
    }
    
    func removeObserver(_ delegate: ThemeManagerDelegate) {
        NotificationCenter.default.removeObserver(delegate, name: .themeDidChange, object: nil)
    }
    
    private func notifyThemeChange() {
        NotificationCenter.default.post(name: .themeDidChange, object: self, userInfo: ["theme": currentTheme.rawValue])
    }
}

extension Notification.Name {
    static let themeDidChange = Notification.Name("themeDidChange")
}
