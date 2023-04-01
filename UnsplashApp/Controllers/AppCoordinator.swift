//
//  AppCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func start() {
        let controller = TabBarController()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
