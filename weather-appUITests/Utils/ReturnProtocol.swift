//
//  ReturnProtocol.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 20.02.23.
//

import XCTest
import SBTUITestTunnelClient

protocol ReturnProtocol: BaseScreen {
    
    func tapSearchButtonAndReturnTo<T>(screen: T.Type) -> T where T: BaseScreen
}

extension ReturnProtocol {
    
    func tapSearchButtonAndReturnTo<T>(screen: T.Type) -> T where T: BaseScreen {
        XCTContext.runActivity(named: "Tap Search Button and return the Screen option") { _ in
            tapSearchButton()
            return T.init()
        }
    }
    
    func tapSearchButton() {
        XCTContext.runActivity(named: "Tap Search Button if hittable") { _ in
            let searchButton: Button = .init(element: BaseTest.shared.app.buttons["searchButton"])
            searchButton.assert(state: .hittable)?.tap()
        }
    }
}
