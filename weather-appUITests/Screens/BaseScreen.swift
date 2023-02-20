//
//  BaseScreen.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 19.02.23.
//

import XCTest
import SBTUITestTunnelClient

class BaseScreen {
    lazy var app: SBTUITunneledApplication! = BaseTest.shared.app
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    let visibleTimeout = 5.0
    
    required init() { }
}
