//
//  ViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit
import SnapKit

final class PicturesListViewController: UIViewController {
    
    // MARK: - Public
    var unsplashData: [ImageURLs] = []
    weak var delegate: Presenter?
    
    // MARK: - Private
    private let photoGalleryManager = PhotoGalleryManager.shared
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (view.frame.size.width - 20) / 3,
                                 height: (view.frame.size.width - 30) / 3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PicturesListCollectionViewCell.self,
                                forCellWithReuseIdentifier: PicturesListCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        return refreshControl
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getImages()
    }
    
    // MARK: - Network
    func getImages() {
        photoGalleryManager.randomImagesList { [weak self] imagesArray in
            guard let self = self else { return }
            
            self.unsplashData = imagesArray
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    //MARK: - Collection view refresh
    @objc private func refreshList() {
        self.getImages()
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

// MARK: - Setup views
private extension PicturesListViewController {
 
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.addSubview(refreshControl)
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        navigationItem.titleView = searchBar
    }
}

// MARK: - Collection view data source and delegate
extension PicturesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        unsplashData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesListCollectionViewCell.identifier, for: indexPath) as! PicturesListCollectionViewCell
        cell.backgroundColor = .systemGray6
        let model = unsplashData[indexPath.row]
        cell.configure(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pictureInfoModel = photoGalleryManager.presentPhotoArray[indexPath.item]
        
        let selectedIsFavorite = photoGalleryManager.favoritesArray.contains {
            return $0 == pictureInfoModel
        }
        pictureInfoModel.isFavorite = selectedIsFavorite
        delegate?.presentPhoto(with: pictureInfoModel)
    }
}
