//
//  HomeViewFactory.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

struct PicturesListViewFactory {
    static func create() -> UIViewController {
        let viewController = PicturesListViewController()
        
        return viewController
    }
}
