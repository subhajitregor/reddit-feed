//
//  Post_RouterTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 26/04/22.
//

import XCTest
@testable import reddit_feed

class Post_RouterTest: XCTestCase {
    
    var sut: PostRouter!
    var openTransition: TransitionSpy!
    var vcA: ViewControllerMock!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = PostRouter()
        openTransition = TransitionSpy()
        vcA = ViewControllerMock()
        
        sut.openTransition = openTransition
        sut.rootController = vcA
        
        vcA.router = sut
        
    }
    
    override func tearDown() {
        sut = nil
        vcA = nil
        openTransition = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_closing() {
        
        vcA.close()
        
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
        var router: PostRoutingLogic!
        
        func close() {
            router.needsClosing()
        }
    }
}
