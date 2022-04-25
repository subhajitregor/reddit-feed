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
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    private var interactor: PostBusinessLogic?
    
    // MARK: Injection
    
    func setInteractor(interactor: PostBusinessLogic?) {
        self.interactor = interactor
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.start()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        interactor?.closeScene()
    }
}

extension PostViewController: PostDisplayLogic {
    func displayPost(viewModel: Post.FeedPost.ViewModel) {
        setupTitle(with: viewModel.author)
        
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
    
    func displayError(error: Error) {
        // Note: Needs to be implemented for missing data.
    }
}

private extension PostViewController {
    
    func setupTitle(with authorName: String) {
        self.title = "Posted by: \(authorName)"
    }
}
