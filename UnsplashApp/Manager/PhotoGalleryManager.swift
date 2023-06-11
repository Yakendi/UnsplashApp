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
    var presentPhotoArray: [PresentPhotoModel] = []
    var favoritesArray: [PresentPhotoModel] = []
    weak var delegate: PhotoGalleryManagerDelegate?
    
    // MARK: - Private properties
    private let network = ServiceFactory.shared
    private let storageManager = DataBaseManager()
    
    // MARK: - Constructor
    init() {
        favoritesArray = storageManager.fetchFavoritesArray()
    }
    
    // MARK: - Update favorites list
    func addToFavorites(_ model: PresentPhotoModel) {
        self.favoritesArray.append(model)
        self.delegate?.updateFavoritesList()
        self.storageManager.saveFavoritesModel(model)
    }
    
    func deleteFromFavorites(_ model: PresentPhotoModel, isNeedReload: Bool) {
        let filteredArray = self.favoritesArray.filter { $0 != model }
        self.favoritesArray = filteredArray
        self.storageManager.removeFromFavoritesModel(model)
        
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
    
//    func searchImagesList(with keyWord: String, page: Int, completion: @escaping ImagesCompletion) {
//        network.searchImages(with: keyWord, page: page) { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let response):
//                downloadImages(response)
//                completion(response.map { $0.urls })
//            case .failure(_):
//                print(NetworkErrorTypes.emptyData)
//            }
//        }
//    }
}
