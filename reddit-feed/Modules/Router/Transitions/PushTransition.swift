//
//  PushTransition.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

final class PushTransition: Transition {
    weak var viewController: UIViewController?
    
    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
