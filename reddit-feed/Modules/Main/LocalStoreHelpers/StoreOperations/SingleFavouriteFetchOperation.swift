//
//  SingleFavouriteFetchOperation.swift
//  reddit-feed
//
//  Created by Subhajit on 28/04/22.
//

import Foundation

protocol SingleFavouriteFetchOperation {
    func fetchPost(for id: String) -> Result<Favourites, Error>
}

extension SingleFavouriteFetchOperation where Self: LocalStoreReadable {
    func fetchPost(for id: String) -> Result<Favourites, Error> {
        do {
            guard let object = try loadObject(Favourites.self, upon: "postId", value: id) else {
                print("Entry with id: \(id) - Not found")
                let error = NSError(domain: "DB", code: 1) // TODO: Move this error to proper wrapper
                return .failure(error)
            }
            return .success(object)
        } catch {
            return .failure(error)
        }
    }
}
