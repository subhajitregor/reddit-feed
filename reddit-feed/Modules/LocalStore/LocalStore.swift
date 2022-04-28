//
//  LocalStore.swift
//  reddit-feed
//
//  Created by Subhajit on 27/04/22.
//

import Foundation
import CoreData



protocol LocalStoreReadable {
    func loadObjects<T: NSManagedObject>(_ objects : T.Type) throws -> [T]
    func loadObject<T: NSManagedObject>(_ object: T.Type, upon key: String, value: String) throws -> T?
}

protocol LocalStoreWritable {
    func save(in currentContext: @escaping (NSManagedObjectContext) -> ()) async throws
}
//
//protocol LocalStoreDeleteable {
//    func remove<T: DataModel>(_ object: T)
//}

typealias LocalStore = LocalStoreReadable & LocalStoreWritable //& LocalStoreDeleteable
