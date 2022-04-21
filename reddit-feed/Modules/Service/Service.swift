//
//  Service.swift
//  reddit-feed
//
//  Created by Subhajit on 21/04/22.
//

import Foundation

typealias ServiceCompletion = (Result<Data?, Error>) -> ()

protocol ServiceCancellable {
    func cancel()
}

protocol ServiceProtocol {
    func request(_ route: EndpointType, completion: @escaping ServiceCompletion)
}

class Service: NSObject, ServiceProtocol, ServiceCancellable {
    private var task: URLSessionTask?
    private var completion: ServiceCompletion?
    
    func request(_ route: EndpointType, completion: @escaping ServiceCompletion) {
        self.completion = completion
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = false
        }
        
        let session = URLSession(configuration: configuration)
        
        task = session.dataTask(with: route.urlRequest) { data, response, error in
            if let error = error as? URLError {
                let requestError = RequestErrorBuilder.handleError(error)
                completion(.failure(requestError))
            } else {
                let responseError = ResponseErrorBuilder.handleNetworkResponse(response)
                
                switch responseError {
                case .none:
                    completion(.success(data))
                default:
                    completion(.failure(responseError))
                }
            }
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
