//
//  CoreDataService.swift
//  reddit-feed
//
//  Created by Subhajit on 27/04/22.
//

import Foundation
import CoreData



class CoreDataStore: LocalStore {
    
    private(set) var modelName: String = "reddit_feed"
    
    let logger = AppLogger(category: .dataStore)
    
    private(set) lazy var mainContext: NSManagedObjectContext = storeContainer.viewContext
    
    private(set) lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { [weak self] store, error in
            guard let self = self else {
                fatalError("This should never happen: No CoreDataStore instance")
            }
            if let error = error {
                self.logger.error("Unresolved error \(error) \(error.localizedDescription)")
            }
            self.logger.debug("NSPersistance container loaded successfuly")
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    
    func loadObjects<T: ManagedObject>(_ objects : T.Type) throws -> [T] {
        let request = objects.createFetchRequest()
        return try mainContext.fetch(request) as? [T] ?? []
    }
    
    func loadObject<T: ManagedObject>(_ object: T.Type, upon key: String, value: String) throws -> T? {
        let request = object.createFetchRequest()
        request.predicate = NSPredicate(format: "\(key) == %@", value)
        request.fetchLimit = 1
        let objects = try mainContext.fetch(request) as? [T]
        return objects?.first
    }
    
    func save(in currentContext: @escaping (NSManagedObjectContext) -> ()) async throws {
        try await storeContainer.performBackgroundTask { context in
            
            currentContext(context)

            try context.save()
        }
    }
}
