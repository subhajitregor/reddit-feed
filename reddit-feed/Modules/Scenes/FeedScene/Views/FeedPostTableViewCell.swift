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
        let title: NSAttributedString?
        let timestamp: NSAttributedString?
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
        
        self.titleLabel.attributedText = cellData.title
        self.timeStampLabel.attributedText = cellData.timestamp
        
        setUpSubviews()
    }
    
    func setUpSubviews() {
        postImageView.layer.cornerRadius = 4
    }
}

// MARK: Cell Data Extensions

extension FeedPostTableViewCell.CellData {
    init(from feedPost: String) {
        self.title = NSAttributedString(string: feedPost)
        self.timestamp = NSAttributedString("xx-xx-xxxx XX:XX")
        self.imageUrl = "URL for image"
    }
}
