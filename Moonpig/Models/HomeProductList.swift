//
//  HomeProductList.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - HomeItems
struct HomeProductList: Codable {
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products = "Products"
    }
}
