//
//  JSONParameterEncoder.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    static func encodeRequest(_ urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw ServiceRequestError.requestBodyEncodingFailed
        }
    }
    
    
}
