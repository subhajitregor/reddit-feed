//
//  ImageRequestEndpoint.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import UIKit

struct ImageRequestEndpoint: EndpointType {
    var baseURL: String
    var path: String = ""
    var httpMethod: HTTPMethod = .get
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ServiceResponseError.unableToDecode
        }
        
        return image
    }
}
