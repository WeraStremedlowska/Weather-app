//
//  AddLocationStub.swift
//  weather-appUITests
//
//  Created by Wera Stremedlowska on 28.02.23.
//

import SBTUITestTunnelClient

enum AddLocationStub {
    case correctData
    case incorrectData
    case longData
    case unicodeData
    case emptyData
    case failure(code: Int)
    
    func start() {
        let request = SBTRequestMatch(url: "https://api.openweathermap.org/data/2.5/", method: "GET")
        
        switch self {
        case .correctData:
            let response = SBTStubResponse(fileNamed: "CorrectData.json")
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        case .incorrectData:
            let response = SBTStubResponse(fileNamed: "IncorrectData.json")
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        case .longData:
            let response = SBTStubResponse(fileNamed: "LongData.json")
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        case .unicodeData:
            let response = SBTStubResponse(fileNamed: "UnicodeData.json")
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        case .emptyData:
            let response = SBTStubResponse(response: "{ }")
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        case .failure(let code):
            let response = SBTStubResponse(fileNamed: "CorrectData.json", returnCode: code)
            BaseTest.shared.app.stubRequests(matching: request, response: response)
        }
    }
}
