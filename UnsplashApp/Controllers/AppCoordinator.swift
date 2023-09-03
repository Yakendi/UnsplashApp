//
//  AppCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Public properties
    let window: UIWindow
    var navigationController = UINavigationController()
    
    // MARK: - Constructor
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Life cycle
    func start() {
        let controller = TabBarController()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
