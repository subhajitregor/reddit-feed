//
//  ImageService.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import UIKit

protocol ImageServiceLogic {
    func loadImage(_ urlString: String, defaultImage: UIImage, loaded: @escaping (UIImage) -> Void)
}

final class ImageService: Service {
    enum AccessableEndpoints {
        static func imageRequest(url: String) -> ImageRequestEndpoint {
            ImageRequestEndpoint(baseURL: url)
        }
    }
    
    static let shared = ImageService()
}

extension ImageService: ImageServiceLogic {
    func loadImage(_ urlString: String, defaultImage: UIImage = UIImage(), loaded: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            self.request(AccessableEndpoints.imageRequest(url: urlString)) { result in
                switch result {
                case .success(let image):
                    loaded(image)
                case .failure(_):
                    loaded(defaultImage)
                }
            }
        }
    }
}
