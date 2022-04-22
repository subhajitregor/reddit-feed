//
//  EndpointType.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]
typealias RequestParamName = String
typealias RequestParamValue = String

public enum HTTPMethod : String {
    case get = "GET"
}

protocol EndpointType {
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [RequestParamName: RequestParamValue]? { get set }
    
    func decode(_ data: Data) throws -> Response
}

extension EndpointType where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension EndpointType {
    mutating func setParameters(_ parameters: [RequestParamName: RequestParamValue]) {
        self.parameters = parameters
    }
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
