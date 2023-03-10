//
//  AccessibilityIdentifiers.swift
//  weather-app
//
//  Created by Wera Stremedlowska on 15.02.23.
//

import Foundation


typealias AId = AccessibilityIdentifiers

struct AccessibilityIdentifiers {
    struct LaunchScreen {
        static let weatherAppTitle = "weatherAppTitle"
        static let progressViewBar = "progressViewBar"
        static let appImage = "logo"
    }
    
    struct WeatherViewController {
        static let locationButton = "Location"
        static let addCityButton = "Add"
        static let conditionImageView = "conditionImageView"
        static let temperatureLabel = "temperatureLabel"
        static let conditionLabel = "conditionLabel"
    }
    
    struct AddCityViewController {
        static let enterCityLabel = "enterCityLabel"
        static let cityTextField = "cityTextField"
        static let enterCountryLabel = "enterCountryLabel"
        static let countryTextField = "countryTextField"
        static let searchButton = "searchButton"
        static let activityIndicatorView = "activityIndicatorView"
        static let statusLabel = "statusLabel"
    }
}
