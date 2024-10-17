//
//  FeedViewModelTests.swift
//  Navigation
//
//  Created by eva on 17.10.2024.
//

import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {

    var feedModel: FeedModel?
    
    override func setUp() {
        super.setUp()
        feedModel = FeedModel()
    }

    func testInputWordToModelNormal() throws {
        XCTAssertEqual(feedModel?.check(word: "word"), true)
    }
    
    func testInputWordToModelFailed() throws {
        XCTAssertEqual(feedModel?.check(word: "sadawscas"), false)
    }
}
