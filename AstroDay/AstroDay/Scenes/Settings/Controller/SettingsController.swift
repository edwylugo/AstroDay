//
//  SettingsController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit

class SettingsViewController: UIViewController, ThemeManagerDelegate {
    
    private let toolbar = CustomToolbarHeaderView(translateMask: false).apply {
        $0.titleText = Strings.nav_title_settings
        $0.titleFont = .roboto(type: .bold, size: .f20)
    }
    
    private let darkModeSwitch = UISwitch().apply {
        $0.onTintColor = .systemBlue
    }
    
    private let darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.label_text_theme
        return label
    }()
    
    private let darkModeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: SettingsViewModelProtocol
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        ThemeManager.shared.register(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        ThemeManager.shared.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupToolbarTapped()
        configureDarkModeSwitch()
    }
    
    private func configureDarkModeSwitch() {
        themeDidChange(to: ThemeManager.shared.currentTheme.rawValue)
        darkModeSwitch.isOn = ThemeManager.shared.currentTheme == .dark
        darkModeSwitch.addTarget(self, action: #selector(toggleTheme), for: .valueChanged)
    }
    
    @objc private func toggleTheme() {
        let isDarkMode = darkModeSwitch.isOn
        ThemeManager.shared.toggleTheme(isDarkMode: isDarkMode)
    }
    
    func themeDidChange(to theme: Int) {
        let theme = ThemeManager.shared.currentTheme
        view.backgroundColor = theme == .dark ? .black : .white
        toolbar.changeTheme(theme)
        darkModeLabel.textColor = theme == .dark ? .white : .black
        darkModeSwitch.onTintColor = theme == .dark ? .systemBlue : .systemGreen
    }
}

// MARK: - CodeView
extension SettingsViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(toolbar)
        view.addSubview(darkModeStackView)
        
        darkModeStackView.addArrangedSubview(darkModeLabel)
        darkModeStackView.addArrangedSubview(darkModeSwitch)
    }
    
    func setupConstraints() {
        toolbar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: 60
        )
        
        darkModeStackView.anchor(
            top: toolbar.bottomAnchor,
            paddingTop: 20
        )
        
        darkModeStackView.centerX(inView: view)
    }
    
    func setupAdditionalConfiguration() {
        ThemeManager.shared.register(self)
    }
}

// MARK: - Other Methods
extension SettingsViewController {
    func setupToolbarTapped() {
        toolbar.onBackButtonTapped = {
            self.viewModel.shouldBack()
        }
    }
}
