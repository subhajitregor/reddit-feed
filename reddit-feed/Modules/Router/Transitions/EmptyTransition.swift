//
//  EmptyTransition.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

final class EmptyTransition: Transition {
    
    weak var viewController: UIViewController?
    
    func open(_ viewController: UIViewController) {
    }
    
    func close(_ viewController: UIViewController) {
    }
}
