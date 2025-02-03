//
//  APODLoadingView.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import Lottie
import UIKit

final class APODLoadingView: UIView {

    var loading: AnimationView?

    init() {
        super.init(frame: .zero)
        setupLoading()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupLoading() {
        
        loading = AnimationView(name: "atom-loader")
        
        guard let loading = loading else { return }
        
        loading.backgroundColor = .clear
        
        loading.contentMode = .scaleAspectFit
        loading.loopMode = .loop
        loading.isHidden = false
        addSubview(loading)

        loading.anchor(centerX: (anchor: centerXAnchor, padding: 0),
                       centerY: (anchor: centerYAnchor, padding: 0),
                       width: 100,
                       height: 100)
        loading.play()
    }
}
