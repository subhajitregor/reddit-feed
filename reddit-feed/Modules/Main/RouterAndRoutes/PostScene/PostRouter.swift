//
//  PostRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation

final class PostRouter: MainRouter<PostViewController>  {}

extension PostRouter: PostRoutingLogic {
    func needsClosing() {
        close()
    }
}
