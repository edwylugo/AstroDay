//
//  APODMovieViewController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import UIKit
import WebKit

class APODMovieViewController: UIViewController {
    
    var videoURL: URL?
    var webView = WKWebView(frame: .zero).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let closeButton = UIButton(type: .system).apply {
        $0.setTitle(Strings.button_text_closed, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadVideo()
    }
    
    func loadVideo() {
        guard let url = videoURL else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension APODMovieViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(webView)
        view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        webView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
        
        closeButton.anchor(
            top: view.topAnchor,
            paddingTop: 20,
            trailing: view.trailingAnchor,
            paddingRight: 20
        )
    }
    
    func setupAdditionalConfiguration() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}
