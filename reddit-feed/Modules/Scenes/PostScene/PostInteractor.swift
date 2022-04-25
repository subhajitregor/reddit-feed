//
//  PostInteractor.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol PostBusinessLogic {
    func start()
    func closeScene()
}

protocol PostDataProvider {
    var id: String { get }
    var title: String { get }
    var originalImageUrl: String { get }
    var author: String { get }
    var timestamp: Date { get }
}

protocol PostRoutingLogic {
    func needsClosing()
}

final class PostInteractor {
    private var presenter: PostPresentationLogic
    private var dataProvider: PostDataProvider?
    private var router: PostRoutingLogic
    
    init(presenter: PostPresentationLogic, router: PostRoutingLogic) {
        self.presenter = presenter
        self.router = router
    }
    
    func setDataProvider(_ provider: PostDataProvider) {
        self.dataProvider = provider
    }
}

// MARK: - PostBusinessLogic

extension PostInteractor: PostBusinessLogic {
    func start() {
        guard let dataProvider = dataProvider,
            !dataProvider.title.isEmpty,
              !dataProvider.originalImageUrl.isEmpty,
              !dataProvider.author.isEmpty
        else {
            let error = NSError(domain: "Failed to get data", code: 0)
            presenter.presentFailure(error: error)
            return
        }
        let model = Post.FeedPost.Model(originalImageUrl: dataProvider.originalImageUrl,
                                        title: dataProvider.title,
                                        author: dataProvider.author,
                                        timestamp: dataProvider.timestamp)
        
        presenter.presentPost(response: model)
    }
    
    func closeScene() {
        router.needsClosing()
    }
}
