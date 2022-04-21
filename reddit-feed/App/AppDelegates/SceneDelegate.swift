//
//  SceneDelegate.swift
//  reddit-feed
//
//  Created by Subhajit on 20/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootVC = FeedBuilder().build()
        let rootNavigationController = UINavigationController(rootViewController: rootVC)
        rootNavigationController.navigationBar.prefersLargeTitles = true
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }

}

