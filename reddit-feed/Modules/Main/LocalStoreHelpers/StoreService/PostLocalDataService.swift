//
//  PostLocalDataService.swift
//  reddit-feed
//
//  Created by Subhajit on 28/04/22.
//

import Foundation

final class PostLocalDataService: CoreDataStore, PostLocalDataService.Operations {
    typealias Operations = SingleFavouriteFetchOperation
    & InsertFavouriteOperation
}

extension PostLocalDataService: PostLocalStore {
    func addPostToFavourite(id: String, done: @escaping (Result<Bool, Error>) -> Void) {
        insertIntoFavourite(id: id) { result in
            done(result)
        }
    }
    
    func isPostFavourite(id: String) -> Bool {
        let result = fetchPost(for: id)
        
        switch result {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
}
