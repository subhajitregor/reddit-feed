//
//  SceneBuilder.swift
//  reddit-feed
//
//  Created by Subhajit on 20/04/22.
//

import UIKit

protocol SceneBuilder {
    associatedtype Scene: UIViewController
    func build() -> Scene
}
