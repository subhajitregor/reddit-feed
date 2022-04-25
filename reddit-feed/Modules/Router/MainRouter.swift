//
//  MainRouter.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import UIKit

protocol Closable: AnyObject {
    func close()
}

protocol RouterProtocol: AnyObject {
    associatedtype V: UIViewController
    var rootController: V? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
}

class MainRouter<U>: RouterProtocol, Closable where U: UIViewController {
    typealias V = U
    
    weak var rootController: V?
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.rootController
        transition.open(viewController)
    }

    func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = rootController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController)
    }
}
