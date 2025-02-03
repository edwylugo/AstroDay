//
//  APODTableViewCell.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import UIKit
import Kingfisher

protocol APODTableViewCellDelegate: AnyObject {
    func shouldUpdateTable()
    func didToggleFavorite(for apod: APODModel)
}

class APODTableViewCell: UITableViewCell {
    
    weak var delegate: APODTableViewCellDelegate?
    private var currentAPOD: APODModel?
    
    private let viewBackground = UIView().apply {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel(translateMask: false).apply {
        $0.font = .roboto(type: .regular, size: .f16)
        $0.numberOfLines = 1
        $0.textColor = .white
    }
    
    private let dateLabel = UILabel(translateMask: false).apply {
        $0.font = .roboto(type: .thin, size: .f12)
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.textColor = .white
    }
    
    private let explanationLabel = UILabel(translateMask: false).apply {
        $0.font = .roboto(type: .light, size: .f14)
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
        $0.textColor = .white
    }
    
    private let seeMoreButton = UIButton(type: .system).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(Strings.button_more, for: .normal)
        $0.titleLabel?.font = .roboto(type: .light, size: .f13)
        $0.isUserInteractionEnabled = true
    }
    
    private let favoriteButton = UIButton(type: .system).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Images.System.heart, for: .normal)
        $0.tintColor = .white
    }
    
    private let apodImageView = UIImageView(translateMask: false).apply {
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
    
    private var isExpanded = false
    
    private let stackView = UIStackView(translateMask: false).apply {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private let seeMoreContainer = UIView(translateMask: false).apply {
        $0.isUserInteractionEnabled = true
        $0.setHeight(height: 36)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Função para carregar imagem na célula
    func loadImage(from url: String) {
        DispatchQueue.main.async {
            let url = URL(string: url)
            let processor = DownsamplingImageProcessor(size: self.apodImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
            self.apodImageView.kf.indicatorType = .activity
            self.apodImageView.kf.setImage(
                with: url,
                placeholder: UIImage(),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    @objc private func toggleText() {
        isExpanded.toggle()
        explanationLabel.numberOfLines = isExpanded ? 0 : 3
        explanationLabel.lineBreakMode = isExpanded ? .byWordWrapping : .byTruncatingTail
        seeMoreButton.setTitle(isExpanded ? Strings.button_hide : Strings.button_more, for: .normal)
        
        delegate?.shouldUpdateTable()
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupTheme() {
        let theme = ThemeManager.shared.currentTheme
        backgroundColor = theme == .dark ? .black : .white
        contentView.backgroundColor = theme == .dark ? .black : .white
        titleLabel.textColor = theme == .dark ? .white : .black
        dateLabel.textColor = theme == .dark ? .white : .black
        explanationLabel.textColor = theme == .dark ? .white : .black
        apodImageView.layer.shadowColor = theme == .dark ? UIColor.green.cgColor : UIColor.clear.cgColor
        favoriteButton.tintColor = theme == .dark ? .white : .black
    }
    
    @objc private func toggleFavorite() {
        guard let apod = currentAPOD else { return }
        delegate?.didToggleFavorite(for: apod)
    }
}

extension APODTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(apodImageView)
        contentView.addSubview(dateLabel)
        seeMoreContainer.addSubview(favoriteButton)
        seeMoreContainer.addSubview(seeMoreButton)
        stackView.addArrangedSubviews([
            explanationLabel,
            seeMoreContainer
        ])
    }
    
    func setupConstraints() {
        
        titleLabel.anchor(
            top: contentView.topAnchor,
            paddingTop: 10,
            leading: contentView.leadingAnchor,
            paddingLeft: 16,
            trailing: contentView.trailingAnchor,
            paddingRight: 16
        )
        
        apodImageView.anchor(
            top: titleLabel.bottomAnchor,
            paddingTop: 10,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor
        )
        
        dateLabel.anchor(
            top: apodImageView.bottomAnchor,
            paddingTop: 10,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingRight: 8
        )
        
        stackView.anchor(
            top: dateLabel.bottomAnchor,
            paddingTop: 10,
            leading: contentView.leadingAnchor,
            paddingLeft: 8,
            bottom: contentView.bottomAnchor,
            paddingBottom: 10,
            trailing: contentView.trailingAnchor,
            paddingRight: 8
        )
        
        apodImageView.anchor(
            height: 250
        )
        
        seeMoreButton.anchor(
            top: seeMoreContainer.topAnchor,
            bottom: seeMoreContainer.bottomAnchor,
            trailing: seeMoreContainer.trailingAnchor
        )
        
        favoriteButton.anchor(
            top: seeMoreContainer.topAnchor,
            leading: seeMoreContainer.leadingAnchor,
            bottom: seeMoreContainer.bottomAnchor
        )
    }
    
    func setupAdditionalConfiguration() {
        selectedBackgroundView = viewBackground
        seeMoreButton.addTarget(self, action: #selector(toggleText), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
}

extension APODTableViewCell: Configurable {
    typealias Configuration = APODTableViewCellContent
    
    struct APODTableViewCellContent {
        let aPODModel: APODModel
        
        init(aPODModel: APODModel) {
            self.aPODModel = aPODModel
        }
    }
    
    func configure(content: APODTableViewCellContent) {
        titleLabel.text = content.aPODModel.title
        dateLabel.text = content.aPODModel.date
        explanationLabel.text = content.aPODModel.explanation
        if content.aPODModel.mediaType == "video" {
            apodImageView.image = content.aPODModel.mediaType == "video" ? Images.video : UIImage()
            apodImageView.contentMode = .scaleAspectFill
        } else {
            loadImage(from: content.aPODModel.getThumbnailUrl())
        }
        
        setupTheme()
        if let isFavorite = content.aPODModel.isFavorite {
            let image = isFavorite ? Images.System.heart_fill : Images.System.heart
            favoriteButton.setImage(image, for: .normal)
            favoriteButton.tintColor = isFavorite ? .red : .white
        }
        currentAPOD = content.aPODModel
    }
}
