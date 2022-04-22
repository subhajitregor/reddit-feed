//
//  String+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import Foundation

extension String {
    func toNSAttributedString(from attributes: AttributeContainer.Attributes) -> NSAttributedString {
        NSAttributedString(.init(self, attributes: attributes.rawValue))
    }
}
