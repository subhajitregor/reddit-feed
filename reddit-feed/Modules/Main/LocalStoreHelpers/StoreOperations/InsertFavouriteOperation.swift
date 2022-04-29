//
//  InsertFavouriteOperation.swift
//  reddit-feed
//
//  Created by Subhajit on 28/04/22.
//

import Foundation

protocol InsertFavouriteOperation {
    func insertIntoFavourite(id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

extension InsertFavouriteOperation where Self: LocalStoreWritable {
    func insertIntoFavourite(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Task(priority: .utility) {
            do {
                try await save { (context) in
                    let favourite = Favourites(context: context)
                    favourite.postId = id
                    
                    completion(.success(true))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        
    }
}
