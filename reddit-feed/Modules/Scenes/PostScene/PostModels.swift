//
//  PostModels.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum Post {
    
    // MARK: Use cases
    
    enum FeedPost {
        struct Model {
            let originalImageUrl: String
            let title: String
            let author: String
            let timestamp: Date
        }
        
        struct ViewModel {
            let originalImageUrl: String
            let title: String
            let author: String
            let timestamp: Date
        }
    }
    
    
}
