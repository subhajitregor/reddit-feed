//
//  PostViewController.swift
//  reddit-feed
//
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol PostDisplayLogic: AnyObject {
    func displayPost(viewModel: Post.FeedPost.ViewModel)
    func displayError(error: Error)
}

final class PostViewController: UIViewController, InterfaceIdentifiable {
    
    @IBOutlet private(set) var favouriteButton: UIButton!
    @IBOutlet private(set) var postImageView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var timestampLabel: UILabel!
    
    private var interactor: PostBusinessLogic?
    private var viewModel: Post.FeedPost.ViewModel?
    
    // MARK: Injection
    
    func setInteractor(interactor: PostBusinessLogic?) {
        self.interactor = interactor
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.start()
        setUp()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        interactor?.closeScene()
    }
    
    @IBAction func tappedFavouriteButton(_ sender: Any) {
        guard let viewModel = viewModel else {
            return
        }

        interactor?.userActionOnFavourite(for: viewModel)
    }
    
}

extension PostViewController: PostDisplayLogic {
    func displayPost(viewModel: Post.FeedPost.ViewModel) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.setData(with: viewModel)
        }
    }
    
    func displayError(error: Error) {
        // Note: Needs to be implemented for missing data.
    }
}

private extension PostViewController {
    func setUp() {
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTitle(with authorName: String) {
        self.title = "Posted by: \(authorName)"
    }
    
    func setData(with viewModel: Post.FeedPost.ViewModel) {
        setupTitle(with: viewModel.author)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let `self` = self else { return }
            self.favouriteButton.configuration = viewModel.isFavourite ? .filled() : .tinted()
            let text = self.favouriteButtonText(isFavourite: viewModel.isFavourite)
            self.favouriteButton.setTitle(text, for: .normal)
        }
        
        titleLabel.attributedText = viewModel.title.toNSAttributedString(from: .titleAttribute)
        
        timestampLabel.attributedText = viewModel.timestamp
            .toString(from: .time_on_mmm_space_dd_comma_yyyy)
            .toNSAttributedString(from: .timestampAttribute)
        
        ImageService.shared.loadImage(viewModel.originalImageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        }
    }
    
    func favouriteButtonText(isFavourite: Bool) -> String {
        isFavourite ?
        StaticMessages.Post.FavouriteUIText.remove :
        StaticMessages.Post.FavouriteUIText.add
    }
}
