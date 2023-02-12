//
//  WeatherData.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}
