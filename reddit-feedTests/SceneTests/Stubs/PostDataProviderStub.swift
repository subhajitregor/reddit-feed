//
//  PostDataProviderStub.swift
//  reddit-feedTests
//
//  Created by Subhajit on 26/04/22.
//

import XCTest
@testable import reddit_feed

struct PostDataProviderStub: PostDataProvider {
    var timestamp: Date
    var id: String
    var title: String
    var originalImageUrl: String
    var author: String
}
