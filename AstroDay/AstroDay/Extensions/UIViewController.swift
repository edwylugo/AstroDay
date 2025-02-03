//
//  UIViewController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = Strings.button_text_ok, okHandler: (() -> Void)? = nil, cancelTitle: String? = nil, cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okHandler?()
        }
        alert.addAction(okAction)
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true)
    }
}
