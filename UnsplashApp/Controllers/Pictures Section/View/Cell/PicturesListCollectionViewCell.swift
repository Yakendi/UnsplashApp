//
//  PicturesListCollectionViewCell.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class PicturesListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Setup cell
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
    // MARK: - Configurator
    func configure(_ model: ImageURLs) {
        imageView.kf.setImage(with: URL(string: model.thumb ?? ""))
    }
}

// MARK: - Setup image
private extension PicturesListCollectionViewCell {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubviews(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
