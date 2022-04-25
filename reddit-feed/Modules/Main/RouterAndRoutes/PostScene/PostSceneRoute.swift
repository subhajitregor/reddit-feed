//
//  PostSceneRoute.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation

protocol PostSceneRoute {
    var postSceneTransition: Transition { get }
    func openPostScene(dataProvider: PostDataProvider)
}

extension PostSceneRoute where Self: RouterProtocol {
    var postSceneTransition: Transition {
        PushTransition()
    }
    
    func openPostScene(dataProvider: PostDataProvider) {
        let router = PostRouter()
        router.openTransition = postSceneTransition
        
        let viewController = PostBuilder(dataProvider: dataProvider, router: router).build()
        open(viewController, transition: postSceneTransition)
        
        router.rootController = viewController
    }
}

