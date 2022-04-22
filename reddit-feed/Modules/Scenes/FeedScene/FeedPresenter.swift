//
//  FeedPresenter.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol FeedPresentationLogic {
    func presentSuccess(response: Feed.Fetch.Response)
    func presentFailure(error: Error)
}


final class FeedPresenter {
    private weak var viewController: FeedDisplayLogic?
    
    init(viewController: FeedDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - FeedPresentationLogic

extension FeedPresenter: FeedPresentationLogic {
    func presentSuccess(response: Feed.Fetch.Response) {
        let vmList = response.responseList.map { Feed.ViewModel.FeedPostVM(from: $0) }
        let viewModel = Feed.ViewModel(feedList: vmList)
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentFailure(error: Error) {
        viewController?.displayFailure(error: error)
    }
}
