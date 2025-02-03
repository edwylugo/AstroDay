//
//  FavoriteController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let toolbar = CustomToolbarHeaderView(translateMask: false).apply {
        $0.titleText = Strings.nav_title_favorites
        $0.titleFont = .roboto(type: .bold, size: .f20)
    }
    
    private let tableView = UITableView(translateMask: false).apply {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.allowsSelection = true
    }
    
    private let noFavoritesView = NotFoundView(translateMask: false).apply {
        $0.image = Images.System.heart_fill
        $0.message = Strings.text_no_favorite
    }
    
    private var viewModel: FavoriteViewModelProtocol
    
    init(viewModel: FavoriteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindigs()
        setupToolbarTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTheme()
    }
    
    func setupBindigs() {
        viewModel.dataAPODModel.bind { dataAPODModel in
            if !dataAPODModel.isEmpty {
                self.showTableView()
            } else {
                self.showNoFavoritesView()
            }
        }
    }
    
    private func showTableView() {
        tableView.isHidden = false
        noFavoritesView.isHidden = true
        tableView.reloadData()
    }
    
    private func showNoFavoritesView() {
        tableView.isHidden = true
        noFavoritesView.isHidden = false
    }
    
    private func setupTheme() {
        let theme = ThemeManager.shared.currentTheme
        toolbar.changeTheme(theme)
        view.backgroundColor = theme == .dark ? .black : .white
    }
}

extension FavoriteViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(noFavoritesView)
        view.addSubview(toolbar)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        noFavoritesView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
        
        toolbar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: 60
        )
        
        tableView.anchor(
            top: toolbar.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
    
    func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellClass: APODTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataAPODModel.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let apod = viewModel.dataAPODModel.value[indexPath.row]
        let cell = tableView.dequeue(cellClass: APODTableViewCell.self, indexPath: indexPath)
        cell.configure(
            content: APODTableViewCell.Configuration(aPODModel: apod)
        )
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let apod = viewModel.dataAPODModel.value[indexPath.row]
        if apod.mediaType == "video", let videoURL = URL(string: apod.url) {
            let videoVC = APODMovieViewController(videoURL: videoURL)
            present(videoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - APODTableViewCellDelegate
extension FavoriteViewController: APODTableViewCellDelegate {
    func didToggleFavorite(for apod: APODModel) {
        let removeApodFavorite = apod
        let message = viewModel.removeFavorite(removeApodFavorite)
        view.showToast(message: message)
        viewModel.getFavorites()
    }
    
    func shouldUpdateTable() {
        let lastScrollOffset = tableView.contentOffset
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(lastScrollOffset, animated: false)
    }
}

// MARK: - Others Methods
extension FavoriteViewController {
    func setupToolbarTapped() {
        toolbar.onBackButtonTapped = {
            self.viewModel.shouldBack()
        }
    }
}
