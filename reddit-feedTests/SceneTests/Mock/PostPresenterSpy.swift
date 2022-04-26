//
//  PostPresenterSpy.swift
//  reddit-feedTests
//
//  Created by Subhajit on 25/04/22.
//

import Foundation
@testable import reddit_feed

class PostPresenterSpy: PostPresentationLogic {
    var presented: Int = 0
    var failed: Int = 0
    
    var viewController: PostDisplayLogic!
    
    func presentPost(response: Post.FeedPost.Model) {
        presented += 1
    }
    
    func presentFailure(error: Error) {
        failed += 1
    }
    
    func sendToDisplay(props: PostDetailProps) {
        let vm = Post.FeedPost.ViewModel(originalImageUrl: "",
                                title: props.title,
                                author: props.author,
                                timestamp: props.timeStamp)
        viewController.displayPost(viewModel: vm)
    }
}
