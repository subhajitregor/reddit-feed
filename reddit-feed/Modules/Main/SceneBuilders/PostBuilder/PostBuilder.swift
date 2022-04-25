//
//  PostBuilder.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

final class PostBuilder: SceneBuilder {
    
    private var dataProvider: PostDataProvider
    private var postRouter: PostRoutingLogic
    
    init(dataProvider: PostDataProvider,
         router: PostRoutingLogic) {
        self.dataProvider = dataProvider
        self.postRouter = router
    }
    
    func build() -> PostViewController {
        let viewController: PostViewController = UIStoryboard(from: .post).createViewController()
        
        let presenter: PostPresentationLogic = PostPresenter(viewController: viewController)
        
        let router: PostRoutingLogic = postRouter
        
        let interactor = PostInteractor(presenter: presenter,
                                        router: router)
        interactor.setDataProvider(dataProvider)
        viewController.setInteractor(interactor: interactor)
        
        return viewController
    }
}
