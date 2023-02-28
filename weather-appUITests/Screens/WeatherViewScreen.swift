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
    private lazy var locationButton: Button = .init(element: app.navigationBars.buttons["Location"])
    private lazy var conditionImage: Image = .init(element: app.staticTexts["conditionImage"])
    private lazy var temperatureLabel: Label = .init(element: app.staticTexts["temperatureLabel"])
    private lazy var conditionLabel: Label = .init(element: app.staticTexts["conditionLabel"])
    
    private lazy var locationSystemAlert: LocationAlert = .init(element:
                                        BaseScreen.springboard.alerts.firstMatch, timeout: 2.0)
    private lazy var locationPermissionAlert: Alert = .init(element: app.alerts.firstMatch, timeout: 2.0)
}

// MARK: - Prime functions
extension WeatherViewScreen {
    
    public func addLocation() -> AddCityScreen {
        XCTContext.runActivity(named: "Tap Add Button if hinttable") { _ in
            addCityButton.assert(state: .hittable)?.tap()
            return .init()
        }
    }
    
    public func getCurrentLocation() -> String {
        XCTContext.runActivity(named: "Get current Location if Location Title is not empty") { _ in
            assertNavigationBarTitle()
            if navigationBarTitle.contains(text: "WeatherView") == true {
                XCTFail("Location is not available at this time.")
                return "Error"
            } else {
                let currentLocation = navigationBarTitle.identifier
                print("***** Location: \(currentLocation)")
                return currentLocation
            }
        }
    }
}

//MARK: - Location Verification
extension WeatherViewScreen {
    
    public func verifyLocationChanged(savedLocation: String, expectedLocation: String) {
        _ = XCTContext.runActivity(named: "Wait 2 sec for Location update") { _ in
            sleep(2)
        }
        XCTContext.runActivity(named: "Check if Location changed OR remains the same.") { _ in
            assertNavigationBarTitle()
            guard savedLocation != expectedLocation else {
                navigationBarTitle.assert(for: .identifier, value: expectedLocation)
                print("***** Location remains the same.")
                return
            }
            navigationBarTitle.assert(for: .identifier, value: expectedLocation)
            print("***** Location changed")
        }
    }
    
    @discardableResult
    public func verifyLocationNotChanged(savedLocation: String) -> AddCityScreen {
        XCTContext.runActivity(named: "Verify if Location is not empty AND NOT changed") { _ in
            assertNavigationBarTitle()
            guard navigationBarTitle.contains(text: "WeatherView") == false else {
                XCTFail("Location is not available at this time.")
                return .init()
            }
            navigationBarTitle.assert(for: .identifier, value: savedLocation)
            return .init()
        }
    }

    @discardableResult
    public func verifyLocation(expectedLocation: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Location as expected") { _ in
            assertNavigationBarTitle()
            navigationBarTitle.assert(for: .identifier, value: expectedLocation)
            return .init()
        }
    }

    @discardableResult
    public func verifyLocationNotACountry(countryCode: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Location is not a Country") { _ in
            assertNavigationBarTitle()
            guard !navigationBarTitle.contains(text: countryCode) else {
                XCTFail("Country is the same as \(countryCode)")
                return .init()
            }
            return .init()
        }
    }
}

// MARK: - Weather Status
extension WeatherViewScreen {

    public func collectTemperature() -> String {
        XCTContext.runActivity(named: "Collect the Temperature") { _ in
            assertTemperatureLabel()
            return temperatureLabel.text
        }
    }

    public func collectCondition() -> String {
        XCTContext.runActivity(named: "Collect Weather Condition") { _ in
            assertConditionLabel()
            return conditionLabel.text
        }
    }

    @discardableResult
    public func verifyTemperatureAndCondition(savedTemperature: String,
                                              savedCondition: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Temperature and Weather condition as expected") { _ in
            print("savedTemperature: \(savedTemperature), savedCondition: \(savedCondition)")
            print("temperatureLabel.label: \(temperatureLabel.text), conditionLabel.label: \(conditionLabel.text)")
            temperatureLabel.assert(for: .label, value: savedTemperature)
            conditionLabel.assert(for: .label, value: savedCondition)
            return .init()
        }
    }
}

//MARK: - Elements Assertions
extension WeatherViewScreen {
    
    func assertWeatherViewScreenDisplayed() -> Self {
        XCTContext.runActivity(named: "Verify WeatherView Screen Displayed") { _ in
            assertNavigationBarTitle()
            assertAddCityButton()
            assertLocationButton()
        }
        return self
    }
    
    func assertAddCityButton() {
        _ = XCTContext.runActivity(named: "Add Button Exists") { _ in
            addCityButton.assert(state: .exists, result: true)
        }
    }
    
    func assertLocationButton() {
        _ = XCTContext.runActivity(named: "Location Button Exists") { _ in
            locationButton.assert(state: .exists, result: true)
        }
    }
    
    func assertNavigationBarTitle() {
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

// MARK: - Allerts
extension WeatherViewScreen {

    @discardableResult
    public func checkLocationPermissionAlert(tap button: LocationPermissionAlertChoises) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Check if location Permition Alert appeared") { _ in
            guard locationPermissionAlert.wait(state: .exists, result: false) != nil else {
                locationPermissionAlert
                    .wait(state: .exists, result: true)?
                    .assertAlert(title: "Requires Location Permission",
                                 body: "Would you like to enable location permission in Settings?",
                                 buttons: ["Cancel", "Go to Settings"])
                    .tapButton(name: button.rawValue)
                verifyLocationPermissionAlertDismissed()
                XCTFail("***** Location for WeatherApp is disabled on your device.")
                return .init()
            }
            return .init()
        }
    }

    @discardableResult
    public func checkLocationSystemAlert(tap button: LocationSystemAlertChoises) -> WeatherViewScreen {
        // Unable to add XCTContext
        guard locationSystemAlert.wait(state: .exists, result: false) != nil else {
            locationSystemAlert
                .wait(state: .exists, result: true)?
                .assertAlert(title: "Allow “WeatherApp” to use your location?",
                             body: "Your location is required to show your local weather",
                             buttons: ["Allow While Using App", "Allow Once", "Don’t Allow"])
                .tapButton(name: button.rawValue)
            verifyLocationSystemAlertDismissed()
            return .init()
        }
        return .init()
    }

    @discardableResult
    public func verifyLocationSystemAlertDismissed() -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Location System Alert dismissed when tapping the option") { _ in
            locationSystemAlert.assert(state: .exists, result: false)
            return .init()
        }
    }

    @discardableResult
    public func verifyLocationPermissionAlertDismissed() -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Location Permition Alert dismissed when tapping the option") { _ in
            locationPermissionAlert.assert(state: .exists, result: false)
            return .init()
        }
    }
}

// MARK: - Stabbing

extension WeatherViewScreen {

    @discardableResult
    public func verifyDataResponse(expectedLocation: String,
                                   expectedCondition: String,
                                   expectedTemp: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Stubbed Response as expected") { _ in
            assertNavigationBarTitle()
            assertConditionLabel()
            assertTemperatureLabel()

            navigationBarTitle.assert(for: .identifier, value: expectedLocation)
            conditionLabel.assert(for: .label, value: expectedCondition)
            temperatureLabel.assert(for: .label, value: expectedTemp)
            return .init()
        }
    }

    @discardableResult
    public func verifyMultipleRowsDataResponse(expectedLocation: String,
                                               expCondition1: String,
                                               expCondition2: String,
                                               expectedTemp: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify if Stubbed Response as expected") { _ in
            assertNavigationBarTitle()
            assertConditionLabel()
            assertTemperatureLabel()

            navigationBarTitle.assert(for: .identifier, value: expectedLocation)
            verifyMultipleRowsText(textRow1: expCondition1, textRow2: expCondition2)
            temperatureLabel.assert(for: .label, value: expectedTemp)
            return .init()
        }
    }

    @discardableResult
    func verifyMultipleRowsText(textRow1: String, textRow2: String) -> Self {
        XCTContext.runActivity(named: "Verify multiple rows text in Weather Condition") { _ in
            XCTAssert(conditionLabel.contains(text: textRow1) && conditionLabel.contains(text: textRow2))
            return self
        }
    }
}

// MARK: - Enums

enum LocationPermissionAlertChoises: String {
    case cancel = "Cancel"
    case goToSettings = "Go to Settings"
}

enum LocationSystemAlertChoises: String {
    case allowWhileUsingApp =  "Allow While Using App"
    case allowOnce = "Allow Once"
    case dontAllow = "Don't Allow"
}
