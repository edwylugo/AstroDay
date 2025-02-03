//
//  UIView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import Foundation
import UIKit

extension UIView {
    convenience init(translateMask: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = translateMask
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeadingAnchor = superview?.leftAnchor,
              let superviewTrailingAnchor = superview?.rightAnchor else { return }
        
        anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor,
               bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor)
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setHeightMultiplier(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchor, multiplier: m).isActive = true
    }
    
    func setDimension(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func removeAllConstraints() {
        var superv = self.superview
        
        while let superview = superv {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            superv = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}

extension UIView {
    func anchor(centerX:(anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                centerY: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                top: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                left: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                right: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                bottom: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.padding).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.padding).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top.anchor, constant: top.padding).isActive = true
        }
        
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left.anchor, constant: left.padding).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right.anchor, constant: -right.padding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.padding).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIView {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let theme = ThemeManager.shared.currentTheme
        
        let toastView = UIView()
        toastView.backgroundColor = theme == .dark ? UIColor.white.withAlphaComponent(0.8) : UIColor.black.withAlphaComponent(0.8)
        toastView.alpha = 0.0
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = theme == .dark ? .black : .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        
        toastView.addSubview(toastLabel)
        self.addSubview(toastView)
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            toastView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            toastView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            toastLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 12),
            toastLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -12),
            toastLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            toastLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}
