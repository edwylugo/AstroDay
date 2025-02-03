//
//  UIFont.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import UIKit
import Foundation

extension UIFont {
    enum Size {
        case f1
        case f2
        case f3
        case f4
        case f5
        case f6
        case f7
        case f8
        case f9
        case f10
        case f11
        case f12
        case f13
        case f14
        case f15
        case f16
        case f17
        case f18
        case f19
        case f20
        case f21
        case f22
        case f23
        case f24
        case f25
        case f26
        case f27
        case f28
        case f29
        case f30

        var value : CGFloat {
            switch self {
            case .f1: return 1.0
            case .f2: return 2.0
            case .f3: return 3.0
            case .f4: return 4.0
            case .f5: return 5.0
            case .f6: return 6.0
            case .f7: return 7.0
            case .f8: return 8.0
            case .f9: return 9.0
            case .f10: return 10.0
            case .f11: return 11.0
            case .f12: return 12.0
            case .f13: return 13.0
            case .f14: return 14.0
            case .f15: return 15.0
            case .f16: return 16.0
            case .f17: return 17.0
            case .f18: return 18.0
            case .f19: return 19.0
            case .f20: return 20.0
            case .f21: return 21.0
            case .f22: return 22.0
            case .f23: return 23.0
            case .f24: return 24.0
            case .f25: return 25.0
            case .f26: return 26.0
            case .f27: return 27.0
            case .f28: return 28.0
            case .f29: return 29.0
            case .f30: return 30.0
            }
        }
    }

    enum Roboto: String {
        case black = "Roboto-Black"
        case blackItalic = "Roboto-BlackItalic"
        case bold = "Roboto-Bold"
        case boldItalic = "Roboto-BoldItalic"
        case italic = "Roboto-Italic"
        case light = "Roboto-Light"
        case lightItalic = "Roboto-LightItalic"
        case medium = "Roboto-Medium"
        case mediumItalic = "Roboto-MediumItalic"
        case regular = "Roboto-Regular"
        case thin = "Roboto-Thin"
        case thinItalic = "Roboto-ThinItalic"
    }

    static func roboto(type: UIFont.Roboto, size: Size) -> UIFont {
        return UIFont(name: type.rawValue, size: size.value) ?? UIFont.systemFont(ofSize: size.value)
    }
}
