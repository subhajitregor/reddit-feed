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
    func moveToDetail(with post: Feed.ViewModel.FeedPostVM) {
        openPostScene(dataProvider: makePostRouterData(from: post))
    }
}

private extension FeedRouter {
    func makePostRouterData(from feedDataPassed: Feed.ViewModel.FeedPostVM) -> PostSceneRoutingData {
        PostSceneRoutingData(id: feedDataPassed.id,
                             title: feedDataPassed.title,
                             originalImageUrl: feedDataPassed.originalImageURL,
                             author: feedDataPassed.author,
                             timestamp: feedDataPassed.timestamp)
    }
}
