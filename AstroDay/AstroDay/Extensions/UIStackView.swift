//
//  UIStackView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach{ self.addArrangedSubview($0) }
    }
    
    func removeFull(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFull(view: view)
        }
    }
}
