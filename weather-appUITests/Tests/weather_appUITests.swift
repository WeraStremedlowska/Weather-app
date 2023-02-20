//
//  weather_appUITests.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 18.02.23.
//

import XCTest

class weather_appUITests: BaseTest {

    func testEnterErrorCountry() throws {
        
        let addCityButton = app.buttons["Add"]
        addCityButton.tap()
        
        let cityTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
                cityTextField.tap()
        cityTextField.typeText("Paris")
        let countryTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
                countryTextField.tap()

        let searchButton = app.buttons["Search"]
        searchButton.tap()
        let statusLabel = app.staticTexts["Country cannot be empty."]
        
        XCTAssert(statusLabel.exists)
        
    }
}
