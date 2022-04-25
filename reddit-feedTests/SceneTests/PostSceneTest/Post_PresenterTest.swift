//
//  Post_PresenterTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 25/04/22.
//

import XCTest
@testable import reddit_feed

class Post_PresenterTest: XCTestCase {
    
    var sut: PostPresenter!
    var viewController: ViewControllerSpy!

    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        viewController = ViewControllerSpy()
        sut = PostPresenter(viewController: viewController)
    }

    override func tearDown() {
        viewController = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_postDisplaySuccess() {
        sut.presentPost(response: makeFeedPostModel())
        
        XCTAssertEqual(viewController.postDisplayed, 1)
    }
    
    func test_onFailure_displayError() {
        let error = NSError()
        sut.presentFailure(error: error)
        
        XCTAssertEqual(viewController.failureDisplayed, 1)
    }
    
    // MARK: Helpers
    
    class ViewControllerSpy: PostDisplayLogic {
        var postDisplayed: Int = 0
        var failureDisplayed: Int = 0
        
        func displayPost(viewModel: Post.FeedPost.ViewModel) {
            postDisplayed += 1
        }
        
        func displayError(error: Error) {
            failureDisplayed += 1
        }
    }
    
    func makeFeedPostModel() -> Post.FeedPost.Model {
        Post.FeedPost.Model(originalImageUrl: "_",
                            title: "_",
                            author: "_",
                            timestamp: Date())
    }
}
