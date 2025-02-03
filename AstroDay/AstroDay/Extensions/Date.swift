//
//  Date.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import UIKit
import Foundation

extension Date {
    func formattedAPODDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
