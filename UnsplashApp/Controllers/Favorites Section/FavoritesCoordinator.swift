//
//  FavoritesCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    
    // MARK: - Public properties
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    // MARK: - Life cycle
    func start() {
        let controller = FavoritesListViewFactory.create()
        self.navigationController.setViewControllers([controller], animated: false)
    }
}

extension FavoritesCoordinator: PresentPhotoDelegate {
    func presentPhoto() {
        let detailPictureViewController = DetailPictureViewController()
        self.navigationController.present(detailPictureViewController, animated: true)
    }
}
