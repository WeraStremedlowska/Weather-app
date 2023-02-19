//
//  BaseScreen.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 19.02.23.
//

import XCTest

class BaseScreen {
    static let app = XCUIApplication()
    
    let visibleTimeout: TimeInterval = 2.0
    
    func tap(_ element: XCUIElement) {
        guard element.waitForExistence(timeout: visibleTimeout) else {
            XCTFail("\(element.description) is not visible")
            return
        }
        element.tap()
    }

    func type(_ text: String, element: XCUIElement) {
        guard element.waitForExistence(timeout: visibleTimeout) else {
            XCTFail("\(element.description) is not visible")
            return
        }
        element.typeText(text)
    }
}
