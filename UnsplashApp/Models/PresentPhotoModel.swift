//
//  PresentPhotoModel.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import Foundation

struct PresentPhotoModel: Equatable {
    let id: String
    let image: String
    let thumbImage: String
    let userAvatar: String
    let userName: String
    let instagram: String
    var isFavorite: Bool = false
    
    static func == (lhs: PresentPhotoModel, rhs: PresentPhotoModel) -> Bool {
        return lhs.id == rhs.id
    }
}
