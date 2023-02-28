//
//  StubbedTests.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 28.02.23.
//

import XCTest
import SBTUITestTunnelClient

class StubbedTests: BaseTest {

    func testAddLocationByCityStubbed() {
        let city = "London"
        let country = "GB"
        let expectedLocation = "Vera, EG"
        let expectedCondition1 = "Stubbed In"
        let expectedCondition2 = "Vera, EG"
        let expectedTemp = "100°C"

        let weatherViewScreen = WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButton()
            .verifySuccessMessage()
            .assertWeatherViewScreenDisplayed()

        let savedLocation = weatherViewScreen.getCurrentLocation()

        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButton(stub: .correctData)
            .verifySuccessMessage()
            .assertWeatherViewScreenDisplayed()
            .verifyMultipleRowsDataResponse(
                                    expectedLocation: expectedLocation,
                                    expCondition1: expectedCondition1,
                                    expCondition2: expectedCondition2,
                                    expectedTemp: expectedTemp)
            .verifyLocationChanged(savedLocation: savedLocation,
                                   expectedLocation: expectedLocation)
    }
}
