//
//  WrappedMangedObject.swift
//  reddit-feed
//
//  Created by Subhajit on 28/04/22.
//

import CoreData

protocol ManagedObject: AnyObject {
    associatedtype Object: NSManagedObject
    static func createFetchRequest() -> NSFetchRequest<Object>
}
