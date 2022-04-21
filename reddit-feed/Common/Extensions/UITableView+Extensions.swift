//
//  UITableView+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: InterfaceIdentifiable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: InterfaceIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return cell
    }
}


