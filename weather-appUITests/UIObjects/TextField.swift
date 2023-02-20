//
//  TextField.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import XCTest

class TextField: BaseElement {
    
    @discardableResult
    func type(text: String) -> Self {
        if hasFocus() == false {
            element.tap()
        }
        element.typeText(text)
        return self
    }
    
    func hasFocus() -> Bool {
        let hasKeyboardFocus = (element.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        return hasKeyboardFocus
    }
    
    func clearAndTypeText(text: String, to textField: TextField) {
        textField.clearText(textField: textField)
        textField.type(text: text)
    }
    
    func clearText(textField: TextField) {
        guard let textFieldValue = textField.value else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        textField.tap()
        let deleteTextFieldValue = String(repeating: XCUIKeyboardKey.delete.rawValue, count: textFieldValue.count)
        textField.type(text: deleteTextFieldValue)
    }
}
