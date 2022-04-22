//
//  FeedService.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

final class FeedService: Service {
    enum AccessableEndpoints {
        static var feed = FeedEndpoint()
    }
}

extension FeedService: FeedServiceLogic {
    func fetchFeeds(completion: @escaping (Result<Feed.Fetch.Response, Error>) -> Void) {
        request(AccessableEndpoints.feed) { result in
            switch result {
                
            case .success(let feedList):
                let response = Feed.Fetch.Response(responseList: feedList)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

