//
//  NotFoundView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

class NotFoundView: UIView {

    private let imageView = UIImageView(translateMask: false).apply {
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let messageLabel = UILabel(translateMask: false).apply {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTheme()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupTheme()
    }
    
    func setupTheme() {
        let theme = ThemeManager.shared.currentTheme
        imageView.tintColor = theme == .dark ? .lightGray : .gray
        messageLabel.textColor = theme == .dark ? .lightGray : .gray
    }
}

extension NotFoundView: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(messageLabel)
    }
    
    func setupConstraints() {
        imageView.centerX(
            inView: self
        )
        
        imageView.centerY(
            inView: self,
            paddingLeft: -20
        )
        
        imageView.anchor(
            width: 60,
            height: 60
        )
        
        messageLabel.anchor(
            top: imageView.bottomAnchor,
            paddingTop: 10,
            leading: leadingAnchor,
            paddingLeft: 20,
            trailing: trailingAnchor,
            paddingRight: 20
        )
        
        messageLabel.centerX(inView: self)
    }
}
