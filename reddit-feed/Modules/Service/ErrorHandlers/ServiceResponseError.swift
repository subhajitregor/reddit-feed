//
//  ServiceResponseError.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

enum ServiceResponseError: Error {

    case none
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    
    case Custom(message:String)
    
    var errorMessage: String {
        switch self {
        case .none:
            return "No Response Error"
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."

        case .Custom(let message):
            return message
        }
    }
}

// MARK: NetworkResponseError Builder

final class ResponseErrorBuilder {
    class func handleNetworkResponse(_ response: URLResponse?) -> ServiceResponseError {
        guard let response = response as? HTTPURLResponse else {
            return ServiceResponseError.Custom(message: "Response is not of Type: HTTPURLResponse")
        }

        switch response.statusCode {
        case 200...299: return ServiceResponseError.none
        case 401...500: return ServiceResponseError.authenticationError
        case 501...599: return ServiceResponseError.badRequest
        case 600: return ServiceResponseError.outdated
        default: return ServiceResponseError.failed
        }
    }
}

