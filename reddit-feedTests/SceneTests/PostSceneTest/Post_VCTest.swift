//
//  Post_VCTest.swift
//  reddit-feedTests
//
//  Created by Subhajit on 25/04/22.
//

import XCTest
@testable import reddit_feed

class Post_VCTest: XCTestCase {
    
    var sut: PostViewController!
    var interactor: InteractorSpy!
    var presenter: PostPresenterSpy!
    var defaultProps: PostDetailProps!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = makeSUT()
        
        presenter = PostPresenterSpy()
        presenter.viewController = sut
        
        defaultProps = makeDefaultProps()
        
        interactor = InteractorSpy()
        interactor.presenter = presenter
        interactor.props = defaultProps
        
        
        sut.setInteractor(interactor: interactor)
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_onViewDidLoad_callsStart() {
        sut.viewDidLoad()
        
        XCTAssertEqual(interactor.startCalled, 1)
    }
    
    func test_closeSceneCalled() {
        sut.tappedCloseButton([])
        
        XCTAssertEqual(interactor.closeCalled, 1)
    }
    
    func test_displayingValues() {
        presenter.viewController = sut
        interactor.presenter = presenter
        let props = PostDetailProps(title: "S", author: "H", timeStamp: Date(timeIntervalSinceNow: 20))
        interactor.props = props
        
        sut.render(props)
        
        XCTAssertEqual(sut.title, "Posted by: H")
        XCTAssertEqual(sut.titleLabel.attributedText, "S".toNSAttributedString(from: .titleAttribute))
        XCTAssertEqual(sut.timestampLabel.attributedText, Date(timeIntervalSinceNow: 20).toString(from: .time_on_mmm_space_dd_comma_yyyy).toNSAttributedString(from: .timestampAttribute))
    }
    
    // MARK: Helpers
    func makeSUT() -> PostViewController {
        let sut: PostViewController = UIStoryboard(from: .post).createViewController()
        sut.loadViewIfNeeded()
        return sut
    }
    
    func makeDefaultProps() -> PostDetailProps {
        PostDetailProps(title: "_",
                        author: "_",
                        timeStamp: Date())
    }
    
    class InteractorSpy: PostBusinessLogic {
        
        
        
        var startCalled: Int = 0
        var closeCalled: Int = 0
        
        var presenter: PostPresenterSpy!
        
        var props: PostDetailProps!
        
        func start() {
            startCalled += 1
            presenter.sendToDisplay(props: props)
        }
        
        func closeScene() {
            closeCalled += 1
        }
        
        func userActionOnFavourite(for post: Post.FeedPost.ViewModel) {
            
        }
    }
}

struct PostDetailProps {
    let title: String
    let author: String
    let timeStamp: Date
}

protocol PostDetailComponent: AnyObject {
    func render(_ props: PostDetailProps)
}

extension PostViewController: PostDetailComponent {
    func render(_ props: PostDetailProps) {
        titleLabel.attributedText = props.title.toNSAttributedString(from: .titleAttribute)
        timestampLabel.attributedText = props.timeStamp
            .toString(from: .time_on_mmm_space_dd_comma_yyyy)
            .toNSAttributedString(from: .timestampAttribute)
        title = "Posted by: \(props.author)"
    }
}
