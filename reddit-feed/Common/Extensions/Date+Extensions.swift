//
//  Date+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 22/04/22.
//

import Foundation

extension Date {
    func toString(from format: DateFormatter.Format) -> String {
        format.rawValue.string(from: self)
    }
}
