//
//  Cache_Test.swift
//  reddit-feedTests
//
//  Created by Subhajit on 27/04/22.
//

import XCTest
@testable import reddit_feed

class Cache_Test: XCTestCase {
    var sut: Cache<String, String>!
    var timeInterval: Double!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        timeInterval = 5
        sut = Cache<String, String>(dateProvider: Date.init, entryLifetime: timeInterval)
    }
    
    override func tearDown() {
        timeInterval = 0
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test
    
    func test_canKeep_value_throughSubscript() {
        sut["x"] = "Val_1"
        
        XCTAssertEqual(sut["x"], "Val_1")
    }
    
    func test_value_lifetime_throughSubscripts() {
        let key = "k"
        let value = "Val_1"
        sut[key] = value
        
        let expectation = self.expectation(description: "Validation")
        
        var cacheValue: String?
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            cacheValue = self.sut[key]
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(cacheValue, value)
        
        let expectation2 = self.expectation(description: "ValidationError")
        
        var nocacheValue: String?
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            nocacheValue = self.sut[key]
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(nocacheValue)

    }
    
    func test_assigningNil_throughSubscripts_removesValue() {
        let key = "k"
        let value = "Val_1"
        sut[key] = value
        
        XCTAssertNotNil(sut[key])
        
        sut[key] = nil
        
        XCTAssertNil(sut[key])
    }

}
