//
//  CacheManager.swift
//  weather-app
//
//  Created by Wera Stremedlowska on 18.02.23.
//

import Foundation

struct CacheManager {
    
    private let vault = UserDefaults.standard
    
    enum Key: String {
        case city
        case country
    }
    
    func cacheCityCountry(cityName: String, countryName: String) {
        vault.set(cityName, forKey: Key.city.rawValue)
        vault.set(countryName, forKey: Key.country.rawValue)
    }
    
    func getCachedCity() -> String? {
        return vault.value(forKey: Key.city.rawValue) as? String
    }
    
    func getCachedCountry() -> String? {
        return vault.value(forKey: Key.country.rawValue) as? String
    }
}
