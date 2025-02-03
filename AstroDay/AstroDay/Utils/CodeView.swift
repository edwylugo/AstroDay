//
//  CodeView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupViews()
}

extension CodeView {
    func buildViewHierarchy() {}
    func setupConstraints() {}
    func setupAdditionalConfiguration() {}
    func setupViews() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
