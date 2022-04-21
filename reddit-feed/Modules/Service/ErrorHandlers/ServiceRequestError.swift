//
//  ServiceRequestError.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

enum ServiceRequestError: Error {
    case cancelledByUser
    case timeOut
    case noInternet(_ message: String)
    case notHandled
}

final class RequestErrorBuilder {
    class func handleError(_ error: URLError) -> ServiceRequestError {
        switch error.code {
        case .notConnectedToInternet:
            return .noInternet(error.localizedDescription)
        case .timedOut:
            return .timeOut
        case .cancelled:
            return .cancelledByUser
        default:
            return .notHandled
        }
    }
}
