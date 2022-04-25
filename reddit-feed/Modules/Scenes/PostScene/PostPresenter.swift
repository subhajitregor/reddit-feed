//
//  PostPresenter.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol PostPresentationLogic {
    func presentPost(response: Post.FeedPost.Model)
    func presentFailure(error: Error)
}


final class PostPresenter: PostPresentationLogic {
    private weak var viewController: PostDisplayLogic?
    
    init(viewController: PostDisplayLogic) {
        self.viewController = viewController
    }
        
    // MARK: Do something
    
    
    func presentPost(response: Post.FeedPost.Model) {
        let viewModel = createViewModel(from: response)
        viewController?.displayPost(viewModel: viewModel)
    }
    
    func presentFailure(error: Error) {
        viewController?.displayError(error: error)
    }
    
    private func createViewModel(from model: Post.FeedPost.Model) -> Post.FeedPost.ViewModel {
        Post.FeedPost.ViewModel(originalImageUrl: model.originalImageUrl,
                                title: model.title,
                                author: model.author,
                                timestamp: model.timestamp)
    }
}
