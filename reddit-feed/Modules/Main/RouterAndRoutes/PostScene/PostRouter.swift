//
//  PostRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

final class PostRouter: MainRouter<UIViewController>  {}

extension PostRouter: PostRoutingLogic {
    func needsClosing() {
        close()
    }
}
