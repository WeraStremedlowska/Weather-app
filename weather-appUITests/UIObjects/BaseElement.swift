//
//  BaseElement.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import XCTest

class BaseElement {
    let element: XCUIElement
    let timeout: Double
    
    init(element: XCUIElement, timeout: Double = 8.0) {
        self.element = element
        self.timeout = timeout
    }
}

// MARK: - States
extension BaseElement {
    var exists: Bool {
        element.exists
    }
    
    var hittable: Bool {
        element.isHittable
    }
    
    var selected: Bool {
        element.isSelected
    }
    
    var enabled: Bool {
        element.isEnabled
    }
}

// MARK: - Values
extension BaseElement {
    var text: String {
        return element.label
    }
    
    var identifier: String {
        XCTContext.runActivity(named: "Identifier") { _ in
            return element.identifier
        }
    }
    
    var frame: CGRect {
        return element.frame
    }
    
    var value: String? {
        return element.value as? String
    }
    
    var description: String {
        return element.description
    }
}
    
// MARK: - Gestures
extension BaseElement {
    func tap() {
        element.tap()
    }
        
    func longPress(forDuration seconds: Double = 5.0) {
        element.press(forDuration: seconds)
    }
        
    func forceTap() {
        element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
    }
        
    func swipe(direction: SwipeDirection) {
        switch direction {
        case .up:
                element.swipeUp()
        case .down:
                element.swipeDown()
        case .left:
                element.swipeLeft()
        case .right:
                element.swipeRight()
            }
        }
    }
    
// MARK: - Wait & Assert
extension BaseElement {
    // Wait for element state
    @discardableResult
    func wait(state: ElementState = .exists, result: Bool = true) -> Self? {
        let predicate = NSPredicate(format: "\(state.rawValue) == \(result)")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed ? self : nil
    }
    
    //Wait for value
    @discardableResult
    func wait(for attribute: ElementAttribute, value: Any) -> Self? {
        let predicate = NSPredicate(format: "\(attribute.rawValue) == \"\(value)\"")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed ? self : nil
    }
    
    @discardableResult
    func assert(state: ElementState = .exists, result: Bool = true) -> Self? {
        if wait(state: state, result: result) == nil {
            XCTFail("Element: state: \(state.rawValue) is not equal to \(result).")
            return nil
        }
        return self
    }
    
    @discardableResult
    func assert(for attribute: ElementAttribute, value: Any) -> Self? {
        if wait(for: attribute, value: value) == nil {
            XCTFail("Element: value of \(attribute) is not equal to \(value).")
            return nil
        }
        return self
    }
}

enum SwipeDirection: String {
    case up, down, left, right
}

enum ElementState: String {
    case exists
    case hittable = "isHittable"
    case selected = "isSelected"
    case enabled = "isEnabled"
}

enum ElementAttribute: String {
    case label
    case identifier
    case frame
    case value
}

enum AttributeState: String {
    case isEmpty
}

