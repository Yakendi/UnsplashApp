//
//  ViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit
import SnapKit

class PicturesListViewController: UIViewController {
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width - 40) / 3,
                                 height: (view.frame.size.width - 40) / 3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PicturesListCollectionViewCell.self,
                                forCellWithReuseIdentifier: PicturesListCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup views
private extension PicturesListViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubviews(collectionView, searchBar, activityIndicator)
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.titleView = searchBar
//        activityIndicator.startAnimating()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - Collection view data source and delegate
extension PicturesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesListCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    
}
