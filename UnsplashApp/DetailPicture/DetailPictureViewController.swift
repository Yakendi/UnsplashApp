//
//  DetailPictureViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 04.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class DetailPictureViewController: UIViewController {
    
    // MARK: - Public
    var model: PresentPhotoModel!
    
    // MARK: - Private
    private let photoGalleryManager = PhotoGalleryManager.shared
    
    // MARK: - UI
    // images
    private var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    // labels
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private var instagramUsername: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    // buttons
    private var actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPink
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        button.layer.shadowColor = UIColor.systemGray2.cgColor
        button.layer.shadowOpacity = 0.5
        button.alpha = 0.7
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fillElements()
    }
    
    // MARK: - Configurator
    private func fillElements() {
        // images
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(with: URL(string: model.image))
        profileImageView.kf.setImage(with: URL(string: model.userAvatar))
        
        // labels
        usernameLabel.text = model.userName
        instagramUsername.text = "@\(model.instagram)"
        
        // buttons
        let actionButtonTitle = model.isFavorite ? "Remove from favorites" : "Add to favorites"
        actionButton.setTitle(actionButtonTitle, for: .normal)
    }
    
    // MARK: - Button method
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func addToFavorites() {
        if model.isFavorite {
            photoGalleryManager.deleteFromFavorites(model, isNeedReload: true)
            actionButton.setTitle("Add to favorites", for: .normal)
            actionButton.zoomIn()
            model.isFavorite = false
        } else {
            photoGalleryManager.addToFavorites(model)
            actionButton.setTitle("Remove from favorites", for: .normal)
            actionButton.zoomIn()
            model.isFavorite = true
        }
    }
}

// MARK: - Setup views
private extension DetailPictureViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        // images
        view.addSubviews(pictureImageView)
        pictureImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.68)
        }
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(pictureImageView.snp.bottom).offset(20)
        }
        
        // labels
        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(pictureImageView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(instagramUsername)
        instagramUsername.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        // buttons
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.width.equalTo(260)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
