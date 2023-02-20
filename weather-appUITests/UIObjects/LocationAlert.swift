//
//  LocationAlert.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import Foundation

class LocationAlert: Alert {
    
    func tapAllowWhileUsingApp() {
        tapButton(index: 0)
    }
    
    func tapAllowOnce() {
        tapButton(index: 1)
    }
    
    func tapDontAllow() {
        tapButton(index: 2)
    }
}
