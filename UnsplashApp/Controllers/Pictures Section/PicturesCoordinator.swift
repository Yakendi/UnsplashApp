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
        self.navigationController.setViewControllers([controller], animated: false)
    }
}

extension PicturesCoordinator: PresentPhotoDelegate {
    func presentPhoto() {
        let detailPictureViewController = DetailPictureViewController()
        self.navigationController.present(detailPictureViewController, animated: true)
    }
}
