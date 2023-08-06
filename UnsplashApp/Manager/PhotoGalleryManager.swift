//
//  PhotoGaleryManager.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 10.06.2023.
//

import Foundation

protocol PhotoGalleryManagerDelegate: AnyObject {
    func updateFavoritesList()
}

typealias ImagesCompletion = ([ImageURLs]) -> Void

final class PhotoGalleryManager {
    
    // MARK: - Singletone
    static let shared = PhotoGalleryManager()
    
    // MARK: - Public properties
    weak var delegate: PhotoGalleryManagerDelegate?
    
    // MARK: - Private properties
    private let network = ServiceFactory.shared
    private let storageManager = DataBaseManager()
    private(set) var presentPhotoArray: [PresentPhotoModel] = []
    private(set) var favoritesArray: [PresentPhotoModel] = []
    
    // MARK: - Constructor
    init() {
        favoritesArray = storageManager.fetchFavoritesArray()
    }
    
    // MARK: - Update favorites list
    func addToFavorites(_ model: PresentPhotoModel) {
        favoritesArray.append(model)
        delegate?.updateFavoritesList()
        storageManager.saveFavoritesModel(model)
    }
    
    func deleteFromFavorites(_ model: PresentPhotoModel, isNeedReload: Bool) {
        favoritesArray.removeAll { $0 == model }
        storageManager.removeFromFavoritesModel(model)
        
        if isNeedReload {
            self.delegate?.updateFavoritesList()
        }
    }
    
    // MARK: - Network
    func downloadData(_ response: [UnsplashModel]) {
        self.presentPhotoArray = response.map({ item -> PresentPhotoModel in
            return PresentPhotoModel(
                id: item.id,
                image: item.urls.regular ?? "",
                thumbImage: item.urls.thumb ?? "",
                userAvatar: item.user.profileImage.medium,
                userName: item.user.username,
                instagram: item.user.instagramUsername ?? ""
            )
        })
    }
    
    func randomImagesList(completion: @escaping ImagesCompletion) {
        network.getImages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                downloadData(response)
                completion(response.map { $0.urls })
            case .failure(_):
                print(NetworkErrorTypes.emptyData)
            }
        }
    }
}
