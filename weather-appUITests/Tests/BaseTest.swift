//
//  BaseTest.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 19.02.23.
//

import XCTest
import SBTUITestTunnelClient

class BaseTest: XCTestCase {
    
    static var shared: BaseTest!
    
    override func setUp() {
        super.setUp()
        BaseTest.shared = self
        continueAfterFailure = false
        app.launch()
    }
}
