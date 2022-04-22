//
//  FeedPost.swift
//  reddit-feed
//
//  Created by Subhajit on 22/04/22.
//

import Foundation

struct RedditFeed: Decodable {
    
    struct FeedPost: Decodable {
        let title: String
        let thumbnail: String
        let originalImage: String // url
        let createdAt: Date // created_utc
        
        enum CodingKeys: String, CodingKey {
            case title, thumbnail
            case originalImage = "url"
            case createdAt = "created"
            case data
        }
    }
    
    let after: String
    let dist: Int
    let feedList: [FeedPost] // children
    
    enum CodingKeys: String, CodingKey {
        case after, dist
        case feedList = "children"
        case data
    }
}

extension RedditFeed {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        after = try dataContainer.decode(String.self, forKey: .after)
        dist = try dataContainer.decode(Int.self, forKey: .dist)
        
        feedList = try dataContainer.decode([FeedPost].self, forKey: .feedList)
        
    }
}

extension RedditFeed.FeedPost {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        title = try dataContainer.decode(String.self, forKey: .title)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        originalImage = try dataContainer.decode(String.self, forKey: .originalImage)
        createdAt = try dataContainer.decode(Date.self, forKey: .createdAt)
    }
}
