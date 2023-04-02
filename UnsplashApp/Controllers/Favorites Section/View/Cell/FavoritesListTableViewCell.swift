//
//  FavoritesListTableViewCell.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import UIKit
import SnapKit

class FavoritesListTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    private var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let usernameLabel = UILabel()
    let instagramUsernameLabel = UILabel()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.pictureImageView.image = nil
    }
    
    // MARK: - Configurator
    func configure() {
        pictureImageView.backgroundColor = .systemGray6
        usernameLabel.text = "Username"
        instagramUsernameLabel.text = "@Instagram"
    }
}

// MARK: - Setup views
private extension FavoritesListTableViewCell {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubviews(pictureImageView, usernameLabel, instagramUsernameLabel)
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.leading.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        instagramUsernameLabel.snp.makeConstraints {
            $0.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
