//
//  FeedViewController.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func displaySuccess(viewModel: Feed.ViewModel)
    func displayFailure(error: Error)
}

final class FeedViewController: UIViewController, StoryboardIdentifiable {
    @IBOutlet private var feedTable: UITableView!
    
    private var interactor: FeedBusinessLogic?
    
    // MARK: Injection
    
    func setInteractor(interactor: FeedBusinessLogic?) {
        self.interactor = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
}

// MARK: - FeedDisplayLogic

extension FeedViewController: FeedDisplayLogic {
    func displaySuccess(viewModel: Feed.ViewModel) {
    }
    
    func displayFailure(error: Error) {
        
    }
}

// MARK: Private Methods

private extension FeedViewController {
    func setUp() {
        setNavigationItem()
    }
    
    func setNavigationItem() {
        self.title = "Feed"
    }
}
