//
//  FeedRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation
import UIKit

final class FeedRouter: MainRouter<UIViewController>, FeedRouter.Routes {
    typealias Routes = PostSceneRoute
    var openPostTransition: Transition = PushTransition()
}

extension FeedRouter: FeedRoutingLogic {
    func moveToDetail(with post: Feed.ViewModel.FeedPostVM) {
        openPostScene(transition: openPostTransition, dataProvider: makePostRouterData(from: post))
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
