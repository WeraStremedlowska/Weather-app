//
//  Title.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import Foundation

class Title: BaseElement {
    
    func contains(text: String) -> Bool {
        let hasContainsText = description.contains(text) as Bool
        return hasContainsText
    }
}
