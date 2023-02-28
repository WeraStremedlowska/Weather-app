//
//  AddCityScreen.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 19.02.23.
//

import XCTest
import SBTUITestTunnelClient

class AddCityScreen: BaseScreen, ReturnProtocol {
    
    private lazy var cityTextField: TextField = .init(element: app.textFields["cityTextField"])
    private lazy var countryTextField: TextField = .init(element: app.textFields["countryTextField"])
    private lazy var searchButton: Button = .init(element: app.buttons["searchButton"])
    private lazy var statusLabel: Label = .init(element: app.staticTexts["statusLabel"])
    
    @discardableResult
    func tapSearchButton(stub: AddLocationStub? = nil) -> AddCityScreen {
        XCTContext.runActivity(named: "Find Stubbed? result when tapping hittable Search Button") { _ in
            stub?.start()
            searchButton.assert(state: .hittable)?.tap()
            return .init()
        }
    }
}

//MARK: - Type/Clear/ClearAndType
extension AddCityScreen {
    
    public func typeCity(city: String) -> Self {
        XCTContext.runActivity(named: "Type City") { _ in
            cityTextField.type(text: city)
            return self
        }
    }
    
    public func typeCountry(country: String) -> Self {
        XCTContext.runActivity(named: "Type Country") { _ in
            countryTextField.type(text: country)
            return self
        }
    }
    
    public func clearCity() -> Self {
        XCTContext.runActivity(named: "Clear text in City Field") { _ in
            cityTextField.clearText(textField: cityTextField)
            return self
        }
    }
    
    public func clearCountry() -> Self {
        XCTContext.runActivity(named: "Clear text in Country Field") { _ in
            countryTextField.clearText(textField: countryTextField)
            return self
        }
    }
    
    public func clearAndTypeCity(city: String) -> Self {
        XCTContext.runActivity(named: "Clear text and type City") { _ in
            cityTextField.clearAndTypeText(text: city, to: cityTextField)
            return self
        }
    }
    
    public func clearAndTypeCountry(country: String) -> Self {
        XCTContext.runActivity(named: "Clear text and type Country") { _ in
            countryTextField.clearAndTypeText(text: country, to: countryTextField)
            return self
        }
    }
}

//MARK: - Success/Error
extension AddCityScreen {
    
    @discardableResult
    public func verifySuccessMessage() -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify 'Success!' message") { _ in
            statusLabel.assert(for: .label, value: "Success!")
            return .init()
        }
    }
    
    @discardableResult
    public func verifyError(expectedError: String) -> WeatherViewScreen {
        XCTContext.runActivity(named: "Verify Error message if recognizable error") { _ in
            assertStatusLabel()
//            XCTAssertFalse(((statusLabel.isEmpty()) == true), "Unrecognizable error")
            statusLabel.assert(for: .label, value: expectedError)
            return .init()
        }
    }
    
    @discardableResult
    func verifyMultiRowsError(expectedError1: String, expectedError2: String) -> Self {
        XCTContext.runActivity(named: "Verify multiple rows Error message") { _ in
            let error = statusLabel.text.description
            print(error)

            print(statusLabel.contains(text: expectedError1))
            print(statusLabel.contains(text: expectedError1))

            XCTAssert(statusLabel.contains(text: expectedError1) && statusLabel.contains(text: expectedError2))
            return self
        }
    }
}

//MARK: - Elements Assertions
extension AddCityScreen {
    
    func assertAddCityScreenDisplayed() -> Self {
        XCTContext.runActivity(named: "Verify AddCity Screen Displayed") { _ in
            assertSearchButton()
            assertCityTextField()
            assertCountryTextField()
            return self
        }
    }
    
    func assertSearchButton() {
        _ = XCTContext.runActivity(named: "Search Button Exusts") { _ in
            searchButton.assert(state: .exists, result: true)
        }
    }
    
    func assertCityTextField() {
        _ = XCTContext.runActivity(named: "City Text Field Exists") { _ in
            cityTextField.assert(state: .exists, result: true)
        }
    }
    
    func assertCountryTextField() {
        _ = XCTContext.runActivity(named: "Country Text Field Exists") { _ in
            countryTextField.assert(state: .exists, result: true)
        }
    }
    
    func assertStatusLabel() {
        _ = XCTContext.runActivity(named: "Status Label Exists") { _ in
            statusLabel.assert(state: .exists, result: true)
        }
    }
}
