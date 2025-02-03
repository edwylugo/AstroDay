//
//  CustomToolbarView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

class CustomToolbarView: UIView {

    private let filterButton = UIButton(type: .system).apply {
        $0.setImage(Images.System.line_decrease_circle, for: .normal)
        $0.tintColor = .white
    }
    
    private let favoritesButton = UIButton(type: .system).apply {
        $0.setImage(Images.System.heart_fill, for: .normal)
        $0.tintColor = .white
    }
    
    private let menuButton = UIButton(type: .system).apply {
        $0.setImage(Images.System.ellipsis_circle, for: .normal)
        $0.tintColor = .white
    }
    
    var onFilterButtonTapped: (() -> Void)?
    var onFavoritesButtonTapped: (() -> Void)?
    var onMenuButtonTapped: (() -> Void)?
    
    private let leftStackView = UIStackView(translateMask: false).apply {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let rightStackView = UIStackView(translateMask: false).apply {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 10
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    @objc private func filterButtonTapped() {
        onFilterButtonTapped?()
    }

    @objc private func favoritesButtonTapped() {
        onFavoritesButtonTapped?()
    }

    @objc private func menuButtonTapped() {
        onMenuButtonTapped?()
    }
    
    func changeTheme(_ theme: Theme) {
        backgroundColor = .clear
        filterButton.tintColor = theme == .dark ? .white : .black
        favoritesButton.tintColor = theme == .dark ? .white : .black
        menuButton.tintColor = theme == .dark ? .white : .black
    }
}

extension CustomToolbarView: CodeView {
    func buildViewHierarchy() {
        addSubview(leftStackView)
        addSubview(rightStackView)
        leftStackView.addArrangedSubviews([filterButton])
        rightStackView.addArrangedSubviews([favoritesButton, menuButton])
    }
    
    func setupConstraints() {
        leftStackView.anchor(leading: leadingAnchor, paddingLeft: 10)
        leftStackView.centerY(inView: self)
        
        rightStackView.anchor(trailing: trailingAnchor, paddingRight: 10)
        rightStackView.centerY(inView: self)
    }
    
    func setupAdditionalConfiguration() {
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
}
