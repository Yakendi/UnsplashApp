//
//  DataBaseManager.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 11.06.2023.
//

import Foundation
import CoreData

final class DataBaseManager: NSObject {
    
    // MARK: - Private
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PicturesModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresilved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private let request: NSFetchRequest<PresentPhotoEntity> = PresentPhotoEntity.fetchRequest()
    
    // MARK: - Storage
    func fetchFavoritesArray() -> [PresentPhotoModel] {
        var array: [PresentPhotoModel] = []
        
        let viewContext = persistentContainer.viewContext
        
        do {
            let takedData = try viewContext.fetch(request)
            array = takedData.map {
                return PresentPhotoModel(
                    id: $0.id ?? "",
                    image: $0.image ?? "",
                    thumbImage: $0.thumbImage ?? "",
                    userAvatar: $0.userAvatar ?? "",
                    userName: $0.userName ?? "",
                    instagram: $0.instagram ?? ""
                )
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
    func saveFavoritesModel(_ model: PresentPhotoModel) {
        let viewContext = persistentContainer.viewContext
        let toSaveEntity = PresentPhotoEntity(context: viewContext)
        toSaveEntity.id = model.id
        toSaveEntity.image = model.image
        toSaveEntity.thumbImage = model.thumbImage
        toSaveEntity.userAvatar = model.userAvatar
        toSaveEntity.userName = model.userName
        toSaveEntity.instagram = model.instagram
        toSaveEntity.isFavorite = model.isFavorite
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFromFavoritesModel(_ model: PresentPhotoModel) {
        let viewContext = persistentContainer.viewContext
        let predicate = NSPredicate(format: "id like %@", model.id)
        request.predicate = predicate
        
        do {
            let objects = try viewContext.fetch(request)
            for object in objects {
                viewContext.delete(object)
            }
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
