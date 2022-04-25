//
//  FeedRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation

final class FeedRouter: MainRouter<FeedViewController>, FeedRouter.Routes {
    typealias Routes = PostSceneRoute
    
}

extension FeedRouter: FeedRoutingLogic {
    func moveToDetail(with postId: Int) {
        openPostScene(dataProvider: makePostRouterData(from: postId))
    }
}

private extension FeedRouter {
    func makePostRouterData(from feedDataPassed: Int) -> PostSceneRoutingData {
        PostSceneRoutingData(id: "_",
                             title: "Voilence, Voilence, Voilence. I dont Like it. I avoid. But, voilence likes me... I can't avoid.",
                             originalImageUrl: "https://indianmemetemplates.com/wp-content/uploads/I-dont-like-violence-but-violence-likes-me.jpg",
                             author: "Yash",
                             timestamp: Date(timeIntervalSinceNow: -2000))
    }
}
