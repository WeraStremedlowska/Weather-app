//
//  Label.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import XCTest

class Label: BaseElement {
    
    @discardableResult
    func isEmpty() -> Bool {
        let isEmpty = element.label.isEmpty as Bool
        return isEmpty
    }
    
    func contains(text: String) -> Bool {
        XCTContext.runActivity(named: "Contains") { _ in
            let hasContainsText = element.label.description.contains(text) as Bool
            return hasContainsText
        }
    }
}
