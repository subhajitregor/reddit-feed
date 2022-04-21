//
//  StoryboardIdentifiable.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        String(describing: self)
    }
}
