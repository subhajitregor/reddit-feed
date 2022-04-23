//
//  FeedPostTableViewCell.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell, InterfaceIdentifiable {
    
    struct CellData {
        let imageUrl: String
        let title: String?
        let timestamp: String?
    }
    
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timeStampLabel: UILabel!
    
    private var data: CellData? {
        didSet {
            setUpCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: Dependency Injection
    
    func setData(_ data: CellData) {
        self.data = data
    }
}

// MARK: Private Methods

private extension FeedPostTableViewCell {
    func setUpCell() {
        guard let cellData = data else { return }
        
        self.titleLabel.attributedText = cellData.title?.toNSAttributedString(from: .titleAttribute)
        self.timeStampLabel.attributedText = cellData.timestamp?.toNSAttributedString(from: .timestampAttribute)
        
        ImageService.shared.loadImage(cellData.imageUrl)  { [weak self] image in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        }
        
        setUpSubviews()
    }
    
    func setUpSubviews() {
        postImageView.layer.cornerRadius = 4
        titleLabel.numberOfLines = 4
    }
}

// MARK: Cell Data Extensions

extension FeedPostTableViewCell.CellData {
    init(from feedPost: Feed.ViewModel.FeedPostVM) {
        self.title = feedPost.title
        self.timestamp = feedPost.timestamp
        self.imageUrl = feedPost.imageThumbnailUrl
    }
}
