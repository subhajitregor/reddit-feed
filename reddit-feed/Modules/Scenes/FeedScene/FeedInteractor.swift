//
//  FeedInteractor.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

protocol FeedBusinessLogic {
    func fetchAllFeeds(request: Feed.Fetch.Request)
    func openDetailsView(for post: Feed.ViewModel.FeedPostVM)
}

protocol FeedServiceLogic {
    func fetchFeeds(completion: @escaping (Result<Feed.Fetch.Response, Error>) -> Void)
}

protocol FeedRoutingLogic {
    func moveToDetail(with post: Feed.ViewModel.FeedPostVM)
}

protocol FeedDataStore {}

final class FeedInteractor {
    private var presenter: FeedPresentationLogic
    private var service: FeedServiceLogic
    private var router: FeedRoutingLogic

    init(presenter: FeedPresentationLogic,
         service: FeedServiceLogic,
         router: FeedRoutingLogic) {
        self.presenter = presenter
        self.service = service
        self.router = router
    }
}

// MARK: - FeedBusinessLogic
extension FeedInteractor: FeedBusinessLogic {
    func fetchAllFeeds(request: Feed.Fetch.Request) {
        service.fetchFeeds { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentSuccess(response: response)
            case.failure(let error):
                self.presenter.presentFailure(error: error)
            }
        }
    }
    
    func openDetailsView(for post: Feed.ViewModel.FeedPostVM) {
        router.moveToDetail(with: post)
    }
}
