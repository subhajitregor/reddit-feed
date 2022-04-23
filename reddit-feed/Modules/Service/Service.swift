//
//  Service.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

protocol ServiceResponse {
    associatedtype Response
}

extension ServiceResponse {
    
}

protocol ServiceCancellable {
    func cancel()
}

protocol ServiceProtocol {
    func request<Endpoint: EndpointType>(_ route: Endpoint, completion: @escaping (Result<Endpoint.Response, Error>) -> Void)
}

class Service: NSObject, ServiceProtocol, ServiceCancellable {
    private var task: URLSessionTask?
//    private var completion: (Result<T?, Error>) -> Void = {_ in}
    
    func request<Endpoint: EndpointType>(_ route: Endpoint, completion: @escaping (Result<Endpoint.Response, Error>) -> Void) {
//        self.completion = completion
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = false
        }
        
        let session = URLSession(configuration: configuration)
        
        do {
            task = session.dataTask(with: try route.urlRequest) { data, response, error in
                if let error = error as? URLError {
                    let requestError = RequestErrorBuilder.handleError(error)
                    completion(.failure(requestError))
                } else {
                    let responseError = ResponseErrorBuilder.handleNetworkResponse(response)
                    
                    switch responseError {
                    case .none:
                        guard let data = data else {
                            return completion(.failure(ServiceResponseError.noData))
                        }

                        do {
                            try completion(.success(route.decode(data)))
                        } catch let decodingError {
                            completion(.failure(decodingError))
                        }
                    default:
                        completion(.failure(responseError))
                    }
                }
            }
            task?.resume()
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
