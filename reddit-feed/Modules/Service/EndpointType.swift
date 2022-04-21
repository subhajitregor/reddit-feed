//
//  EndpointType.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
}

public enum HTTPMethod : String {
    case get = "GET"
}

extension EndpointType {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        if httpMethod == .get {
            // add query items to url
            guard let parameters = parameters else {
                fatalError("parameters for GET http method must conform to [String: String]")
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return urlComponents?.url
    }
}
