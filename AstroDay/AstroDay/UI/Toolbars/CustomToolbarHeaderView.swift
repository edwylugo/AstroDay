//
//  CustomToolbarHeaderView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

class CustomToolbarHeaderView: UIView {
    
    private let backButton = UIButton(type: .system).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Images.System.arrow_left, for: .normal)
        $0.tintColor = .white
    }
    
    private let titleLabel = UILabel(translateMask: false).apply {
        $0.textColor = .themeDefault
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var titleFont: UIFont? {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    var onBackButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }
    
    func changeTheme(_ theme: Theme) {
        backgroundColor = .clear
        backButton.tintColor = theme == .dark ? .white : .black
        titleLabel.textColor = theme == .dark ? .white : .black
    }
}

extension CustomToolbarHeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        backButton.anchor(leading: leadingAnchor, paddingLeft: 10)
        backButton.centerY(inView: self)
        
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: self)
    }
    
    func setupAdditionalConfiguration() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}
