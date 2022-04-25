//
//  SceneDelegate.swift
//  reddit-feed
//
//  Created by Subhajit on 20/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: AppRouter!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        router = AppRouter(windowScene: windowScene)
        router.start()
    }

}


