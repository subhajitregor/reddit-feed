//
//  URLHost.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

protocol URLHost {
}

extension URLHost where Self: EndpointType {
    private static var staging: String {
        "http://www.reddit.com"
    }
    
    var baseURL: String {
        #if DEBUG
        return Self.staging
        #else
        return ""
        #endif
    }
}

