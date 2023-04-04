//
//  DetailPictureViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 04.04.2023.
//

import UIKit
import SnapKit

class DetailPictureViewController: UIViewController {

    // MARK: - UI
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
    
    private var actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPink
        button.titleLabel?.text = "Press"
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
        return button
    }()
    
    private var usernameLabel = UILabel()
    private var instagramUsername = UILabel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: - Setup views
private extension DetailPictureViewController {
    func setup() {
        setupViews()
        setupConstraints()
        fillLabels()
    }
    
    func setupViews() {
        view.addSubviews(pictureImageView,
                         profileImageView,
                         actionButton,
                         closeButton,
                         usernameLabel,
                         instagramUsername)
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.68)
        }
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(pictureImageView.snp.bottom).offset(20)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(pictureImageView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        instagramUsername.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        actionButton.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func fillLabels() {
        usernameLabel.text = "Username"
        usernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        instagramUsername.text = "@instagram"
        instagramUsername.textColor = .systemGray
    }
}
