//
//  TabBarController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Public properties
    let picturesList = PicturesCoordinator()
    let favoritesList = FavoritesCoordinator()
    
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
        favoritesList.navigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favourite"), tag: 2)
        
        setViewControllers([picturesList.navigationController, favoritesList.navigationController], animated: true)
        tabBar.tintColor = .systemPink
    }
}
