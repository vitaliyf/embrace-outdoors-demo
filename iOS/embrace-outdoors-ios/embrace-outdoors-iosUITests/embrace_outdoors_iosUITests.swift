//
//  embrace_outdoors_iosUITests.swift
//  embrace-outdoors-iosUITests
//
//  Created by David Rifkin on 8/13/24.
//

import XCTest

final class embrace_outdoors_iosUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testExample() throws {
        
    }
}
