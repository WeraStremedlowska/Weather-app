//
//  DoubleExtensions.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 12.02.23.
//

import Foundation

extension Double {
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toFahrenheit() -> Double {
        // current temperature is always in Kelvin
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        // convert to fahrenheit from Kelvin
        let convertedTemperature = temperature.converted(to: .fahrenheit)
        return convertedTemperature.value
    }
    
    func toCelsius() -> Double {
        // current temperature is always in Kelvin
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        // convert to fahrenheit from Kelvin
        let convertedTemperature = temperature.converted(to: .celsius)
        return convertedTemperature.value
    }
}
