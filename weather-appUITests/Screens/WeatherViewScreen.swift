//
//  WeatherViewScreen.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 19.02.23.
//

import XCTest

class WeatherViewScreen: BaseScreen {
    private lazy var navigationBarTitle: Title = .init(element: app.navigationBars.element)
    private lazy var addCityButton: Button = .init(element: app.navigationBars.buttons["Add"])
    private lazy var locationButton: Button = .init(element: app.navigationBars.buttons["Item"])
    private lazy var conditionImage: Image = .init(element: app.staticTexts["conditionImage"])
    private lazy var temperatureLabel: Label = .init(element: app.staticTexts["temperatureLabel"])
    private lazy var conditionLabel: Label = .init(element: app.staticTexts["conditionLabel"])
}

// MARK: - Prime functions
extension WeatherViewScreen {
    
    public func addLocation() -> AddCityScreen {
        XCTContext.runActivity(named: "Tap Add Button if hinttable") { _ in
            addCityButton.assert(state: .hittable)?.tap()
            return .init()
        }
    }
    
//    public func getCurrentLocation() -> String {
//        XCTContext.runActivity(named: "Get current Location if Location Title is not empty") { _ in
//            if navigationBarTitle.contains(text: "WeatherView") == true {
//                XCTFail("Location is not available at this time.")
//            }
//        }
//    }
}

//MARK: - Elements Assertions
extension WeatherViewScreen {
    
    func assertWeatherViewScreenDisplayed() -> Self {
        XCTContext.runActivity(named: "Verify WeatherView Screen Displayed") { _ in
            assertTitle()
            assertAddCityButton()
            assertLocationButton()
//            assertTemperatureLabel()
//            assertConditionLabel()
            return self
        }
    }
    
    func assertAddCityButton() {
        _ = XCTContext.runActivity(named: "Add Button Exists") { _ in
            addCityButton.assert(state: .exists, result: true)
        }
    }
    
    func assertLocationButton() {
        _ = XCTContext.runActivity(named: "Item Button Exists") { _ in
            locationButton.assert(state: .exists, result: true)
        }
    }
    
    func assertTitle() {
        _ = XCTContext.runActivity(named: "Title Exists") { _ in
            navigationBarTitle.assert(state: .exists, result: true)
        }
    }
    
    func assertTemperatureLabel() {
        _ = XCTContext.runActivity(named: "Temperature Label Exists") { _ in
            temperatureLabel.assert(state: .exists, result: true)
        }
    }
    
    func assertConditionLabel() {
        _ = XCTContext.runActivity(named: "Condition Label Exists") { _ in
            conditionLabel.assert(state: .exists, result: true)
        }
    }
}
