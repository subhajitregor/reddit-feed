//
//  ParameterEncoder.swift
//  reddit-feed
//
//  Created by Subhajit on 23/04/22.
//

import Foundation

protocol ParameterEncoder {
    static func encodeRequest(_ urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}
