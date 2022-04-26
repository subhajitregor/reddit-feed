//
//  Feed_RouterTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 26/04/22.
//

import XCTest
@testable import reddit_feed

class Feed_RouterTest: XCTestCase {
    
    var sut: FeedRouter!
    var transition: TransitionSpy!
    var openTransition: TransitionSpy!
    var vcA: ViewControllerMock!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = FeedRouter()
        transition = TransitionSpy()
        openTransition = TransitionSpy()
        vcA = ViewControllerMock()
        
        sut.openTransition = openTransition
        sut.openPostTransition = transition
        sut.rootController = vcA
        
        vcA.router = sut
        
    }
    
    override func tearDown() {
        sut = nil
        transition = nil
        vcA = nil
        
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_moveToDetail_isOpening() {
        vcA.open()
        
        XCTAssertNotNil(transition.viewController)
        
        XCTAssertEqual(transition.opened, 1)
    }
    
    func test_closing() {
        
        vcA.close()
        
        XCTAssertEqual(transition.closed, 0)
        XCTAssertEqual(openTransition.closed, 1)
    }
    
    func test_ClosingFail_onNoTransition() {
        sut.openTransition = nil
        vcA.close()
        
        XCTAssertEqual(openTransition.closed, 0)
    }
    
    func test_ClosingFail_onNoViewController() {
        sut.rootController = nil
        vcA.close()
        
        XCTAssertEqual(openTransition.closed, 0)
    }

    // MARK: Helpers
    
    class TransitionSpy: Transition {
        var viewController: UIViewController?
        var opened: Int = 0
        var closed: Int = 0
        
        func open(_ viewController: UIViewController) {
            opened += 1
        }
        
        func close(_ viewController: UIViewController) {
            closed += 1
        }
    }
    
    class ViewControllerMock: UIViewController {
        var router: (FeedRoutingLogic & Closable)!
        
        func open() {
            router.moveToDetail(with: Feed.ViewModel.FeedPostVM(id: "",
                                                                author: "",
                                                                imageThumbnailUrl: "",
                                                                originalImageURL: "",
                                                                title: "",
                                                                timestamp: Date()))
        }
        
        func close() {
            router.close()
        }
    }
}
