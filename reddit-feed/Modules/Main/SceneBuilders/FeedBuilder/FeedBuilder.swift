//
//  FeedBuilder.swift
//  reddit-feed
//
//  Created by Subhajit on 20/04/22.
//

import UIKit

final class FeedBuilder: SceneBuilder {
    
    func build() -> FeedViewController {
        let viewController: FeedViewController = UIStoryboard(from: .feed).createViewController()
        
        let presenter: FeedPresentationLogic = FeedPresenter(viewController: viewController)
        
        let router: FeedRoutingLogic = FeedRouter()
        let service: FeedServiceLogic = FeedService()
        let interactor: FeedBusinessLogic = FeedInteractor(presenter: presenter,
                                                           service: service,
                                                           router: router)
        
        viewController.setInteractor(interactor: interactor)
        
        return viewController
    }
}

// TODO: Move these to their proper groups

final class FeedRouter: FeedRoutingLogic {
    func moveToDetail(with postId: Int) {}
}

final class FeedService: FeedServiceLogic {
    func fetchFeeds(completion: @escaping (Result<Feed.Fetch.Response, Error>) -> Void) {
        completion(.success(Feed.Fetch.Response()))
    }
}
