//
//  FavoritesListTableViewCell.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import UIKit
import SnapKit

final class FavoritesListTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    // image
    private var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    // labels
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let instagramUsernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.pictureImageView.image = nil
    }
    
    // MARK: - Configurator
    func configure(_ model: PresentPhotoModel) {
        
        // image
        pictureImageView.kf.setImage(with: URL(string: model.thumbImage))
        
        // labels
        usernameLabel.text = model.userName
        instagramUsernameLabel.text = model.instagram
    }
}

// MARK: - Setup views
private extension FavoritesListTableViewCell {
    func setupViews() {
        contentView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.leading.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(instagramUsernameLabel)
        instagramUsernameLabel.snp.makeConstraints {
            $0.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
