//
//  FeedEndpoint.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

struct FeedEndpoint: EndpointType, URLHost {
    var path: String = "/r/pics/.json"
    var httpMethod: HTTPMethod = .get
    var urlParameters: RequestParameters? = ["jsonp": ""]
}

extension FeedEndpoint {
    func decode(_ data: Data) throws -> [RedditFeed.FeedPost] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let response = try decoder.decode(RedditFeed.self, from: data)
        return response.feedList
    }
}
