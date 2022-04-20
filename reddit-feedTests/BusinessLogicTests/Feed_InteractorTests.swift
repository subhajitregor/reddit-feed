//
//  Feed_InteractorTests.swift
//  reddit-feedTests
//
//  Created by Subhajit on 20/04/22.
//

import XCTest
@testable import reddit_feed

class Feed_InteractorTests: XCTestCase {
    let presenter = FeedPresentationSpy()
    let service = FeedServiceSpy()
    let router = FeedRouterSpy()
    
    // MARK: Tests
    
    func test_fetchAllFeeds_fetchFromService() {
        let sut = makeSUT()
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        XCTAssertEqual(service.fetchCount, 1)

        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        XCTAssertEqual(service.fetchCount, 2)
    }

    func test_fetchAllFeeds_onSuccess_SendingToPresenterSuccess() {
        let sut = makeSUT()
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        
        service.callback(.success(Feed.Fetch.Response()))

        XCTAssertEqual(presenter.successCount, 1)
    }
    
    func test_fetchAllFeeds_onFailure_SendingToPresenterFailure() {
        let sut = makeSUT()
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        
        service.callback(.failure(URLError(.timedOut)))
        
        XCTAssertEqual(presenter.failureCount, 1)
    }
    
    func test_routeToDetail() {
        let sut = makeSUT()
        
        let itemId = 1
        sut.openDetailsView(for: itemId)
        
        XCTAssertEqual(router.routingCount, 1)
    }
    
    // MARK: Helpers
    
    func makeSUT() -> FeedInteractor {
        FeedInteractor(presenter: presenter,
                       service: service,
                       router: router)
    }
    
    class FeedPresentationSpy: FeedPresentationLogic {
        var successCount: Int = 0
        var failureCount: Int = 0
        
        func presentSuccess(response: Feed.Fetch.Response) {
            successCount += 1
        }
        
        func presentFailure(error: Error) {
            failureCount += 1
        }
    }
    
    class FeedServiceSpy: FeedServiceLogic {
        let error = URLError(.cancelled)
        var fetchCount: Int = 0
        var callback: ((Result<Feed.Fetch.Response, Error>) -> Void) = { _ in }
        
        func fetchFeeds(completion: @escaping (Result<Feed.Fetch.Response, Error>) -> Void) {
            fetchCount += 1
            self.callback = completion
        }
    }
    
    class FeedRouterSpy: FeedRoutingLogic {
        var routingCount: Int = 0
        
        func moveToDetail(with postId: Int) {
            routingCount += 1
        }
    }
}
