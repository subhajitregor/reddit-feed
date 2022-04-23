//
//  EndpointType.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]
typealias RequestParameters = [String: String]

protocol EndpointType {
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var urlParameters: RequestParameters? { get }
    var bodyParameters: RequestParameters? { get }
    var httpHeaders: HTTPHeaders? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension EndpointType where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension EndpointType {
    var urlParameters: RequestParameters? {
        nil
    }
    
    var bodyParameters: RequestParameters? {
        nil
    }
    
    var httpHeaders: HTTPHeaders? {
        nil
    }
    
    var urlRequest: URLRequest {
        get throws {
            return try request(urlParameters: urlParameters, bodyParameters: bodyParameters, additionalHeader: httpHeaders)
        }
    }
    
    private func request(urlParameters: RequestParameters?,
                         bodyParameters: RequestParameters?,
                         additionalHeader: HTTPHeaders?) throws -> URLRequest {
        guard var baseUrl = URL(string: baseURL) else {
            throw ServiceRequestError.missingURL
        }
        
        if !path.isEmpty {
            baseUrl.appendPathComponent(path)
        }
        
        var request = URLRequest(url: baseUrl)
        
        request.httpMethod = httpMethod.rawValue
        do {
            if urlParameters?.isEmpty ?? true, bodyParameters?.isEmpty ?? true {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                if let urlParameters = urlParameters, !urlParameters.isEmpty {
                    try URLParameterEncoder.encodeRequest(&request, with: urlParameters)
                }
                
                if let bodyParameters = bodyParameters {
                    try JSONParameterEncoder.encodeRequest(&request, with: bodyParameters)
                }
            }
            
            if let additionalHeader = additionalHeader, !additionalHeader.isEmpty {
                for (key, value) in additionalHeader {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
            
            return request
            
        } catch {
            throw error
        }
    }
}
