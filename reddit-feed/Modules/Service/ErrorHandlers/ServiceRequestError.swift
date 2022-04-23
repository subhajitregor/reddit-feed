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
    case missingURL
    case requestBodyEncodingFailed
    
    var errorMessage: String {
        switch self {
        case .cancelledByUser:
            return "Cancelled by user."
        case .timeOut:
            return "Request Timed out"
        case .noInternet(let message):
            return "No Internet. Message: \(message)"
        case .notHandled:
            return "Not Handled"
        case .missingURL:
            return "URL not found"
        case .requestBodyEncodingFailed:
            return "Request Body Encoding Failed"
        }
    }
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
