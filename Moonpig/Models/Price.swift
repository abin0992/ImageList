//
//  Price.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - Price
struct Price: Codable {
    let value: Double
    let currencySymbol: CurrencySymbol

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case currencySymbol = "Currency"
    }
}

enum CurrencySymbol: String, Codable {
    case pound = "£"
}
