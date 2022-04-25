//
//  PostBuilder.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

final class PostBuilder: SceneBuilder {
    
    var dataProvider: PostDataProvider
    
    init(dataProvider: PostDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func build() -> PostViewController {
        let viewController: PostViewController = UIStoryboard(from: .post).createViewController()
        
        let presenter: PostPresentationLogic = PostPresenter(viewController: viewController)
        
        let router: PostRoutingLogic = PostRouter()
        
        let interactor = PostInteractor(presenter: presenter,
                                        router: router)
        interactor.setDataProvider(dataProvider)
        viewController.setInteractor(interactor: interactor)
        
        return viewController
    }
}

// TODO: Move these to their proper groups

final class PostRouter: PostRoutingLogic {
    func needsClosing() {
        
    }
}

