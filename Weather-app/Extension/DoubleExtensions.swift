//
//  DoubleExtensions.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 12.02.23.
//

import Foundation

extension Double {
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
}
