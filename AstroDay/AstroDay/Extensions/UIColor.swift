//
//  UIColor.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import Foundation
import UIKit

extension UIColor {
    fileprivate static func supportedColor(lightHex: Int, darkHex: Int, named: String) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return getColor(hex: darkHex, named: named)
                } else {
                    return getColor(hex: lightHex, named: named)
                }
            }
        } else {
            return getColor(hex: lightHex, named: named)
        }
    }
    
    fileprivate static func getColor(hex: Int, named: String) -> UIColor {
        if #available(iOS 11.0, *) {
            guard let color =  UIColor(named: named) else {
                return UIColor(rgb: hex)
            }
            return color
        } else {
            return UIColor(rgb: hex)
        }
    }
    
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF,
                  green: (rgb >> 8) & 0xFF,
                  blue: rgb & 0xFF)
    }
}

extension UIColor {
    static var themeDefault: UIColor {
        return supportedColor(lightHex: 0xFFFFFF, darkHex: 0x000000, named: "themeDefault")
    }
    
    static var themeDefaultInverse: UIColor {
        return supportedColor(lightHex: 0x000000, darkHex: 0xFFFFFF, named: "themeDefaultInverse")
    }
}
