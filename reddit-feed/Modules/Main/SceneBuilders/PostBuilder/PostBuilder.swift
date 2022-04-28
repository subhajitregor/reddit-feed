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
    private var localStore: PostLocalStore
    
    init(dataProvider: PostDataProvider,
         router: PostRoutingLogic,
         localStore: PostLocalStore) {
        self.dataProvider = dataProvider
        self.postRouter = router
        self.localStore = localStore
    }
    
    func build() -> PostViewController {
        let viewController: PostViewController = UIStoryboard(from: .post).createViewController()
        
        let presenter: PostPresentationLogic = PostPresenter(viewController: viewController)
        
        let interactor = PostInteractor(presenter: presenter,
                                        router: postRouter,
                                        localStore: localStore)
        
        interactor.setDataProvider(dataProvider)
        viewController.setInteractor(interactor: interactor)
        
        return viewController
    }
}
