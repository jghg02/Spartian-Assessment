//
//  CachedCharacterModel+CoreDataProperties.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-07.
//
//

import Foundation
import CoreData

extension CachedCharacterModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedCharacterModel> {
        return NSFetchRequest<CachedCharacterModel>(entityName: "CachedCharacter")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var originName: String?
    @NSManaged public var originUrl: String?
    @NSManaged public var locationName: String?
    @NSManaged public var locationUrl: String?
    @NSManaged public var image: String?
    @NSManaged public var created: String?

}
