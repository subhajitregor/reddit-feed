//
//  Post_InteractorTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 24/04/22.
//

import XCTest
@testable import reddit_feed

class Post_InteractorTest: XCTestCase {

    var sut: PostInteractor!
    var presenter: PostPresenterSpy!
    var dataProvider: DataProviderStub!
    var emptyDataProvider: DataProviderStub!
    var router: RouterSpy!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        
        presenter = PostPresenterSpy()
        router = RouterSpy()
        dataProvider = DataProviderStub(timestamp: Date(),
                                        id: "_",
                                        title: "_",
                                        originalImageUrl: "_",
                                        author: "_")
        emptyDataProvider = DataProviderStub(timestamp: Date(),
                                             id: "",
                                             title: "",
                                             originalImageUrl: "",
                                             author: "")
        sut = makeSUT()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        dataProvider = nil
        
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_onStart_presentingPost() {
        sut.setDataProvider(dataProvider)
        sut.start()
        
        XCTAssertEqual(presenter.failed, 0)
        XCTAssertEqual(presenter.presented, 1)
    }
    
    func test_onStart_failing() {
        sut.setDataProvider(emptyDataProvider)
        sut.start()
        
        XCTAssertEqual(presenter.presented, 0)
        XCTAssertEqual(presenter.failed, 1)
    }
    
    func test_closeVC_gettingCalled() {
        sut.closeScene()
        
        XCTAssertEqual(router.isClosed, 1)
    }
    
    // MARK: Helpers
    
    func makeSUT() -> PostInteractor {
        PostInteractor(presenter: presenter, router: router)
    }
    
    class PresenterSpy: PostPresentationLogic {
        var presented: Int = 0
        var failed: Int = 0
        
        func presentPost(response: Post.FeedPost.Model) {
            presented += 1
        }
        
        func presentFailure(error: Error) {
            failed += 1
        }
    }
    
    class RouterSpy: PostRoutingLogic {
        var isClosed: Int = 0
        
        func needsClosing() {
            isClosed += 1
        }
    }
    
    struct DataProviderStub: PostDataProvider {
        var timestamp: Date
        var id: String
        var title: String
        var originalImageUrl: String
        var author: String
    }
}
