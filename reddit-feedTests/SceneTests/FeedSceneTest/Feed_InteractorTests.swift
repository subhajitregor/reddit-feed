//
//  Feed_InteractorTests.swift
//  reddit-feedTests
//
//  Created by Subhajit on 20/04/22.
//

import XCTest
@testable import reddit_feed

class Feed_InteractorTests: XCTestCase {
    var sut: FeedInteractor!
    var presenter: FeedPresentationSpy!
    var service: FeedServiceSpy!
    var router: FeedRouterSpy!
    var error: ErrorSpy!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        
        presenter = FeedPresentationSpy()
        service = FeedServiceSpy()
        router = FeedRouterSpy()
        sut = FeedInteractor(presenter: presenter,
                             service: service,
                             router: router)
        error = ErrorSpy()
    }
    
    override func tearDown() {
        presenter = nil
        service = nil
        router = nil
        error = nil
        
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_fetchAllFeeds_fetchFromService() {
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        XCTAssertEqual(service.fetchCount, 1)

        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        XCTAssertEqual(service.fetchCount, 2)
    }

    func test_fetchAllFeeds_onSuccess_SendingToPresenterSuccess() {
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        
        service.callback(.success(Feed.Fetch.Response()))

        XCTAssertEqual(presenter.successCount, 1)
    }
    
    func test_fetchAllFeeds_onFailure_SendingToPresenterFailure() {
        sut.fetchAllFeeds(request: Feed.Fetch.Request())
        
        service.callback(.failure(error))
        
        XCTAssertEqual(presenter.failureCount, 1)
    }
    
    func test_routeToDetail() {
        
        let itemId = 1
        sut.openDetailsView(for: itemId)
        
        XCTAssertEqual(router.routingCount, 1)
    }
    
    // MARK: Helpers
    
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
