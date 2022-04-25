//
//  Tansition.swift
//  reddit-feed
//
//  Created by Subhajit on 25/04/22.
//

import Foundation
import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
