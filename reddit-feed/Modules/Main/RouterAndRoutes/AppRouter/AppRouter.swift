//
//  AppRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation
import UIKit


class AppBaseRouter: RouterProtocol {
    
    private var window: UIWindow!
    weak var rootController: UINavigationController?
    
    required init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        self.window.rootViewController = rootController
    }
    
    func open(_ viewController: UIViewController, transition: Transition) {
        self.window.rootViewController = UINavigationController(rootViewController: viewController)
        self.window.makeKeyAndVisible()
    }
}

final class AppRouter: AppBaseRouter, FeedSceneRoute {
    var postSceneTransition: Transition {
        PushTransition()
    }
    
    required init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    func start()  {
        openFeedScene()
    }
}
