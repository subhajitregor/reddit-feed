//
//  FeedBuilder.swift
//  reddit-feed
//
//  Created by Subhajit on 20/04/22.
//

import UIKit

final class FeedBuilder: SceneBuilder {
    
    private var router: FeedRoutingLogic
    private var service: FeedServiceLogic
    
    init(router: FeedRoutingLogic, service: FeedServiceLogic) {
        self.router = router
        self.service = service
    }
    
    func build() -> FeedViewController {
        let viewController: FeedViewController = UIStoryboard(from: .feed).createViewController()
        
        let presenter: FeedPresentationLogic = FeedPresenter(viewController: viewController)
        
        let router: FeedRoutingLogic = router
        let service: FeedServiceLogic = service
        
        let interactor: FeedBusinessLogic = FeedInteractor(presenter: presenter,
                                                           service: service,
                                                           router: router)
        
        viewController.setInteractor(interactor: interactor)
        
        return viewController
    }
}
