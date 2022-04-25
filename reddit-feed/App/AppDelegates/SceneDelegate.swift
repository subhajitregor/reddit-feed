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
        
        let rootVC = PostBuilder(dataProvider: SomeData()).build()//FeedBuilder().build()
        let rootNavigationController = UINavigationController(rootViewController: rootVC)
        rootNavigationController.navigationBar.prefersLargeTitles = true
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }

}

struct SomeData: PostDataProvider {
    var id: String = "_"
    
    var title: String = "Voilence, Voilence, Voilence. I dont Like it. I avoid. But, voilence likes me... I can't avoid."
    
    var originalImageUrl: String = "https://indianmemetemplates.com/wp-content/uploads/I-dont-like-violence-but-violence-likes-me.jpg"
    
    var author: String = "Yash"
    
    var timestamp: Date = Date(timeIntervalSinceNow: -2000)
    
    
}
