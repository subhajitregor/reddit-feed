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
        struct Response {}
    }
    
    struct ViewModel {
        let feedList: [String]
    }
}
