//
//  PostSceneRoute.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation

protocol PostSceneRoute {
    var openPostTransition: Transition { get set }
    func openPostScene(transition: Transition, dataProvider: PostDataProvider)
}

extension PostSceneRoute where Self: RouterProtocol {
    func openPostScene(transition: Transition, dataProvider: PostDataProvider) {
        let router = PostRouter()
        router.openTransition = transition
        
        let viewController = PostBuilder(dataProvider: dataProvider, router: router).build()
        open(viewController, transition: transition)
        
        router.rootController = viewController
    }
}

