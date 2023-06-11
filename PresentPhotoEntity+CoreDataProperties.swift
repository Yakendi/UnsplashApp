//
//  PresentPhotoEntity+CoreDataProperties.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 11.06.2023.
//
//

import Foundation
import CoreData


extension PresentPhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentPhotoEntity> {
        return NSFetchRequest<PresentPhotoEntity>(entityName: "PresentPhotoEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var instagram: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var thumbImage: String?
    @NSManaged public var userAvatar: String?
    @NSManaged public var userName: String?

}

extension PresentPhotoEntity : Identifiable {

}
