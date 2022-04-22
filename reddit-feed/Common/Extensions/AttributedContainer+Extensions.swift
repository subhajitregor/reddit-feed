//
//  AttributedContainer+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 22/04/22.
//

import UIKit

extension AttributeContainer {
    enum Attributes {
        case titleAttribute
        case timestampAttribute
        
        var rawValue: AttributeContainer {
            switch self {
            case .titleAttribute:
                return AttributeContainer([
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
                    NSAttributedString.Key.foregroundColor: UIColor.darkText
                ])
            case .timestampAttribute:
                return AttributeContainer([
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium),
                    NSAttributedString.Key.foregroundColor: UIColor.systemGray2
                ])
            }
        }
    }
}
