//
//  weather_appUITests.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 18.02.23.
//

import XCTest

class weather_appUITests: BaseTest {
    
    func testAddLocation() {
        let city = "Paris"
        let country = "FR"
        
        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifySuccessMessage()
            .assertWeatherViewScreenDisplayed()
    }
    
    func testWrongCityError() {
        let city = "l"
        let country = "FR"
        let expectedError = "city not found"
        
        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifyError(expectedError: expectedError)
    }
}