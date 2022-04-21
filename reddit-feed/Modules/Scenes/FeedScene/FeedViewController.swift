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

final class FeedViewController: UIViewController, InterfaceIdentifiable {
    @IBOutlet private var feedTable: UITableView!
    
    private var interactor: FeedBusinessLogic?
    private var viewModel: Feed.ViewModel? {
        didSet {
            feedTable.reloadData()
        }
    }
    // MARK: Injection
    
    func setInteractor(interactor: FeedBusinessLogic?) {
        self.interactor = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        startFetch()
    }
    
    
}

// MARK: - FeedDisplayLogic

extension FeedViewController: FeedDisplayLogic {
    func displaySuccess(viewModel: Feed.ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayFailure(error: Error) {
        
    }
}

// MARK: Private Methods

private extension FeedViewController {
    func startFetch() {
        interactor?.fetchAllFeeds(request: Feed.Fetch.Request())
    }
    
    func setUp() {
        setNavigationItem()
        registerTableCells()
    }
    
    func setNavigationItem() {
        self.title = "Feed"
    }
    
    func registerTableCells() {
        feedTable.register(FeedPostTableViewCell.self)
    }
}


// MARK: TableView Datasource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.feedList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel?.feedList[indexPath.row] else
        { return UITableViewCell() }
        
        let cell: FeedPostTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let cellData = FeedPostTableViewCell.CellData(from: vm)
        cell.setData(cellData)
        
        return cell
    }
    
    
}
