//
//  Favourites+CoreDataProperties.swift
//  reddit-feed
//
//  Created by Subhajit on 27/04/22.
//
//

import CoreData

extension Favourites {
    @NSManaged public var postId: String
}

extension Favourites : ManagedObject {
    @nonobjc public class func createFetchRequest()
    -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: Favourites.entityName)
    }
}

extension Favourites : Identifiable {

}
