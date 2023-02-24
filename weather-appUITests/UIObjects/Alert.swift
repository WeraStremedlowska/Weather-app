//
//  Alert.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import XCTest

class Alert: BaseElement {
    
    private lazy var alertTitle: Label = .init(element: element.staticTexts.firstMatch)
    private lazy var alertBody: Label = .init(element: element.staticTexts.element(boundBy: 1))
    
    func tapButton(index: Int) {
        let button: Button = .init(element: element.buttons.element(boundBy: index))
        button.tap()
    }
    
    func tapButton(name: String) {
        let button: Button = .init(element: element.buttons[name])
        button.tap()
    }
    
    func labels() -> Label {
        Label(element: element)
    }
    
    func labels(label: String) -> Label {
        Label(element: element)
    }
    
    @discardableResult
    func assertAlert(title: String, body: String, buttons: [String]) -> Self {
        alertTitle.assert(for: .label, value: title)
        alertBody.assert(for: .label, value: body)
        for buttonName in buttons {
            let alertButton: Button = .init(element: element.buttons[buttonName])
            alertButton.assert(state: .exists, result: true)
        }
        return self
    }
}
