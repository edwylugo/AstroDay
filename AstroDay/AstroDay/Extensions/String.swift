//
//  String.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import Foundation

protocol Localizable {
    var localized: String { get }
    func localized(with arguments: CVarArg...) -> String
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let format = NSLocalizedString(self, comment: "")
        return String(format: format, arguments: arguments)
    }
}
