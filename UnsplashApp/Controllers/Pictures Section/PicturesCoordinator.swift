//
//  PicturesCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

class PicturesCoordinator: Coordinator {
    
    // MARK: - Public properties
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    // MARK: - Life cycle
    func start() {
        let controller = PicturesListViewFactory.create()
        controller.delegate = self
        self.navigationController.setViewControllers([controller], animated: false)
    }
}

extension PicturesCoordinator: Presenter {
    func presentPhoto(with model: PresentPhotoModel) {
        let detailPictureViewController = DetailPictureViewController()
        detailPictureViewController.model = model
        self.navigationController.present(detailPictureViewController, animated: true)
    }
}
