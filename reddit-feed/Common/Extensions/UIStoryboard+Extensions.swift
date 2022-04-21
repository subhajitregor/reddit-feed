//
//  UIStoryboard+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import UIKit

extension UIStoryboard {
    convenience init(from storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func createViewController<VC: UIViewController>() -> VC where VC: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC else {
            fatalError("Couldn't find view controller with identifier: \(VC.storyboardIdentifier) in Storyboard: \(String(describing: self))")
        }
        
        return viewController
    }
}

