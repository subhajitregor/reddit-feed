//
//  InterfaceIdentifiable.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

protocol InterfaceIdentifiable {
    static var identifier: String { get }
}

extension InterfaceIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}
