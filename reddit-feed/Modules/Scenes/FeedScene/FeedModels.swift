//
//  FeedModels.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum Feed {
    
    // MARK: Use cases
    
    enum Fetch {
        struct Request {}
        struct Response {
            let responseList: [RedditFeed.FeedPost]
        }
    }
    
    struct ViewModel {
        let feedList: [FeedPostVM]
    }
}

extension Feed.ViewModel {
    final class FeedPostVM {
        var id: String
        var author: String
        var imageThumbnailUrl: String
        var originalImageURL: String
        var title: String
        var timestamp: Date
        
        init(from post: RedditFeed.FeedPost) {
            id = post.id
            author = post.author
            imageThumbnailUrl = post.thumbnail
            originalImageURL = post.originalImage
            title = post.title
            timestamp = post.createdAt
        }
    }
}
