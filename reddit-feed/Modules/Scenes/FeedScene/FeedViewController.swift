//
//  FeedViewController.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func displaySuccess(viewModel: Feed.ViewModel)
}

class FeedViewController: UIViewController {
        
    private var interactor: FeedBusinessLogic?
    
    // MARK: Injection
    
    func setInteractor(interactor: FeedBusinessLogic?) {
        self.interactor = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

// MARK: - FeedDisplayLogic

extension FeedViewController: FeedDisplayLogic {
    func displaySuccess(viewModel: Feed.ViewModel) {
    }
}
