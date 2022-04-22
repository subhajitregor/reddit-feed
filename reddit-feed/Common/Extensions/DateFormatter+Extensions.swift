//
//  DateFormatter+Extensions.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import Foundation

extension DateFormatter {
    enum Format {
        case mmm_space_dd_comma_yyyy
        case time_on_mmm_space_dd_comma_yyyy
        
        var rawValue: DateFormatter {
            let df = DateFormatter()
            df.timeZone = .current
            switch self {
            case .mmm_space_dd_comma_yyyy:
                df.dateFormat = "MMM dd, yyyy"
                
            case .time_on_mmm_space_dd_comma_yyyy:
                df.dateFormat = "h:mm a 'on' MMM dd, yyyy "
            }
            return df
        }
    }
}
