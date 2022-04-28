//
//  Favourites+CoreDataProperties.swift
//  reddit-feed
//
//  Created by Subhajit on 27/04/22.
//
//

import Foundation
import CoreData

extension Favourites {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: Favourites.entityName)
    }

    @NSManaged public var postId: String
}

extension Favourites : Identifiable {

}
