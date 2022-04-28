//
//  PostInteractor.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol PostBusinessLogic {
    func start()
    func closeScene()
    func userActionOnFavourite(for post: Post.FeedPost.ViewModel)
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

protocol PostLocalStore {
    func addPostToFavourite(id: String, done: @escaping (Result<Bool, Error>) -> Void)
    func isPostFavourite(id: String) -> Bool
}

final class PostInteractor {
    private var presenter: PostPresentationLogic
    private var dataProvider: PostDataProvider?
    private var router: PostRoutingLogic
    private var localStore: PostLocalStore
    
    init(presenter: PostPresentationLogic,
         router: PostRoutingLogic,
         localStore: PostLocalStore) {
        self.presenter = presenter
        self.router = router
        self.localStore = localStore
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
        // TODO: Check for favourite
        let model = Post.FeedPost.Model(id: dataProvider.id,
                                        originalImageUrl: dataProvider.originalImageUrl,
                                        title: dataProvider.title,
                                        author: dataProvider.author,
                                        timestamp: dataProvider.timestamp,
                                        isFavourite: true)
        
        presenter.presentPost(response: model)
    }
    
    func closeScene() {
        router.needsClosing()
    }
    
    func userActionOnFavourite(for post: Post.FeedPost.ViewModel) {
        
        localStore.addPostToFavourite(id: post.id) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success:
                self.presenter.presentSuccessAlert(with: StaticMessages.Post.FavouriteMessages.added)
            case .failure(let error):
                self.presenter.presentFailure(error: error)
            }
        }
    }
}
