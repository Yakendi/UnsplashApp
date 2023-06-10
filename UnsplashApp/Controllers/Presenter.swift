//
//  PicturesCoordinator.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 04.04.2023.
//

import Foundation

protocol Presenter: AnyObject {
    func presentPhoto(with model: PresentPhotoModel)
}
