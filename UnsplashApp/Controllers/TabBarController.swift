//
//  TabBarController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Public properties
    let picturesList = PicturesCoordinator()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setubTabs()
    }
}

// MARK: - Tabs
private extension TabBarController {
    func setubTabs() {
        picturesList.navigationController.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "explore"), tag: 1)
        
        setViewControllers([picturesList.navigationController], animated: true)
        tabBar.tintColor = .systemPink
    }
}
