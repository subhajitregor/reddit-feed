//
//  FeedSceneRoute.swift
//  reddit-feed
//
//  Created by Subhajit on 26/04/22.
//

import Foundation

protocol FeedSceneRoute {
    var feedSceneTransition: Transition { get }
    func openFeedScene()
}

extension FeedSceneRoute where Self: RouterProtocol {
    var feedSceneTransition: Transition {
        PushTransition()
    }
    
    func openFeedScene() {
        let router = FeedRouter()
        router.openTransition = feedSceneTransition
        
        let service = FeedService()
        
        let viewController = FeedBuilder(router: router, service: service).build()
        open(viewController, transition: feedSceneTransition)
        
        router.rootController = viewController
    }
}
