//
//  Cache.swift
//  reddit-feed
//
//  Created by Subhajit on 24/04/22.
//

import Foundation
import UIKit

final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<CacheKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 1 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        self.wrapped.totalCostLimit = 50_000_000 // 50 MB
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        var cost = 0
        if let image = value as? UIImage, let data = image.pngData() {
            cost = data.count
        }
        wrapped.setObject(entry, forKey: CacheKey(key), cost: cost)
    }
    
    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: CacheKey(key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: CacheKey(key))
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}

private extension Cache {
    final class CacheKey: NSObject {
        let key: Key
        
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { return key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? CacheKey else { return false }
            
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry: NSDiscardableContent {
        var value: Value?
        let expirationDate: Date
        
        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
        
        func beginContentAccess() -> Bool {
            value != nil
        }
        
        func endContentAccess() {}
        
        func discardContentIfPossible() {
            value = nil
        }
        
        func isContentDiscarded() -> Bool {
            value == nil
        }
    }
}
