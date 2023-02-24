//
//  weather_appUITests.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 18.02.23.
//

import XCTest

class AddLocationTests: BaseTest {
    
    func testAddLocation() {
        let city = "Paris"
        let country = "FR"
        let expectedLocation = "Paris, FR"
        
        let weatherViewScreen = WeatherViewScreen()
        let savedLocation = weatherViewScreen.getCurrentLocation()
        
        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifySuccessMessage()
            .assertWeatherViewScreenDisplayed()
            .verifyLocationChanged(savedLocation: savedLocation, expectedLocation: expectedLocation)
    }
    
    func testWrongCityError() {
        let city = "l"
        let country = "FR"
        let expectedError = "city not found"
        
        let weatherViewScreen = WeatherViewScreen()
        let savedLocation = weatherViewScreen.getCurrentLocation()
        
        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifyError(expectedError: expectedError)
            .verifyLocationNotChanged(savedLocation: savedLocation)
    }
    
    func testWrongCountryError() {
        let city = "Paris"
        let country = "l"
        let expectedError = "city not found"
        
        let weatherViewScreen = WeatherViewScreen()
        let savedLocation = weatherViewScreen.getCurrentLocation()
        
        WeatherViewScreen()
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .typeCountry(country: country)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifyError(expectedError: expectedError)
            .verifyLocationNotChanged(savedLocation: savedLocation)
    }
    
    func testNoCountryError() {
        let city = "London"
        let expectedError = "Country cannot be empty."
        
        let weatherViewScreen = WeatherViewScreen()
        let savedLocation = weatherViewScreen.getCurrentLocation()
        
        WeatherViewScreen()
            // Type only city
            .assertWeatherViewScreenDisplayed()
            .addLocation()
            .assertAddCityScreenDisplayed()
            .typeCity(city: city)
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifyError(expectedError: expectedError)
            
            //Clear all data
            .verifyLocationNotChanged(savedLocation: savedLocation)
            .assertAddCityScreenDisplayed()
            .clearCity()
            .clearCountry()
            .tapSearchButtonAndReturnTo(screen: AddCityScreen.self)
            .verifyError(expectedError: expectedError)
            .verifyLocationNotChanged(savedLocation: savedLocation)
        
        
    }
}
