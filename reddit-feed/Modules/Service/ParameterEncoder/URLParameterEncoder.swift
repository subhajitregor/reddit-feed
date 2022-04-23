//
//  URLParameterEncoder.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static func encodeRequest(_ urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        guard let url = urlRequest.url else { throw ServiceRequestError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

