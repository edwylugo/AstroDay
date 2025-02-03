//
//  HomeViewController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 29/01/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let toolbar = CustomToolbarView(translateMask: false)
    
    private let tableView = UITableView(translateMask: false).apply {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.allowsSelection = true
    }
    
    let noFavoritesView = NotFoundView(translateMask: false).apply {
        $0.image = Images.System.camera_fill
        $0.message = Strings.text_no_found
        $0.isHidden = true
    }
    
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
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
        setupBindigs()
    }
    
    func setupBindigs() {
        viewModel.isLoading.bind { isLoading in
            if isLoading {
                APODLoading.shared.show()
            } else {
                APODLoading.shared.hide()
            }
        }
        
        viewModel.isNotFound.bind { isNotFound in
            if isNotFound {
                self.showNoFavoritesView()
            } else {
                self.showTableView()
            }
        }
        
        viewModel.isError.bind { isError in
            guard let isError = isError else { return }
            if !isError.isEmpty {
                self.showAlert(title: Strings.text_what_a_shame, message: isError)
                self.viewModel.isError.value = nil
            }
        }
        
        viewModel.dataAPODModel.bind { dataAPODModel in
            if !dataAPODModel.isEmpty {
                self.showTableView()
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

// MARK: - CodeView
extension HomeViewController: CodeView {
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
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
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
        viewModel.shouldOpenMovie(apod: apod)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - APODTableViewCellDelegate
extension HomeViewController: APODTableViewCellDelegate {
    func didToggleFavorite(for apod: APODModel) {
        var newApodFavorite = apod
        newApodFavorite.isFavorite = true
        let message = viewModel.addFavorite(newApodFavorite)
        view.showToast(message: message)
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
extension HomeViewController {
    func setupToolbarTapped() {
        toolbar.onFilterButtonTapped = {
            self.selectDateTapped()
        }
        
        toolbar.onFavoritesButtonTapped = {
            self.viewModel.shouldFavorite()
        }
        
        toolbar.onMenuButtonTapped = {
            self.viewModel.shouldSettings()
        }
    }
    
    func selectDateTapped() {
        let datePickerVC = DatePickerViewController()
        datePickerVC.onDateSelected = { [weak self] selectedDate in
            self?.fetchAPOD(for: selectedDate)
        }
        present(datePickerVC, animated: true)
    }
    
    private func fetchAPOD(for date: String) {
        self.viewModel.fetchAPODsSpecificDay(date: date)
    }
}
