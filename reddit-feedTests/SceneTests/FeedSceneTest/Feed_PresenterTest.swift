//
//  Feed_PresenterTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 21/04/22.
//

import XCTest
@testable import reddit_feed

class Feed_PresenterTest: XCTestCase {
    var sut: FeedPresenter!
    var vc: FeedViewControllerSpy!
    var error: ErrorSpy!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        vc = FeedViewControllerSpy()
        sut = FeedPresenter(viewController: vc)
        error = ErrorSpy()
    }
    
    override func tearDown() {
        vc = nil
        error = nil
        
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_presenter_IsCallingSuccess() {
        sut.presentSuccess(response: Feed.Fetch.Response(responseList: []))
        
        XCTAssertEqual(vc.successCount, 1)
    }
    
    func test_presenter_isCallingFailure() {
        sut.presentFailure(error: error)
        
        XCTAssertEqual(vc.failureCount, 1)
    }
    
    // MARK: Helpers
    
    struct SomeError: Error {
        
    }
    
    class FeedViewControllerSpy: FeedDisplayLogic {
        var successCount: Int = 0
        var failureCount: Int = 0
        
        func displaySuccess(viewModel: Feed.ViewModel) {
            successCount += 1
        }
        
        func displayFailure(error: Error) {
            failureCount += 1
        }
    }
}
