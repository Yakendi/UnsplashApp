//
//  FavoritesCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    
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
        controller.delegate = self
        self.navigationController.setViewControllers([controller], animated: false)
    }
}

extension FavoritesCoordinator: Presenter {
    func presentPhoto(with model: PresentPhotoModel) {
        let detailPictureViewController = DetailPictureViewController()
        detailPictureViewController.model = model
        self.navigationController.present(detailPictureViewController, animated: true)
    }
}
