//
//  Feed_PresenterTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 21/04/22.
//

import XCTest
@testable import reddit_feed

class Feed_PresenterTest: XCTestCase {
    let vc = FeedViewControllerSpy()
    let error = ErrorSpy()
    // MARK: Tests
    
    func test_presenter_IsCallingSuccess() {
        let sut = makeSUT()
        sut.presentSuccess(response: Feed.Fetch.Response())
        
        XCTAssertEqual(vc.successCount, 1)
    }
    
    func test_presenter_isCallingFailure() {
        let sut = makeSUT()
        sut.presentFailure(error: error)
        
        XCTAssertEqual(vc.failureCount, 1)
    }
    // MARK: Helpers
    
    func makeSUT() -> FeedPresenter {
        FeedPresenter(viewController: vc)
    }
    
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
