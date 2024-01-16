//
//  ProductCategory.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - ProductCategory
struct ProductCategory: Codable {
    let productCategoryID: Int
    let name: ProductCategoryName

    enum CodingKeys: String, CodingKey {
        case productCategoryID = "ProductCategoryId"
        case name = "Name"
    }
}

enum ProductCategoryName: String, Codable {
    case flowers = "flowers"
    case foodGifts = "food gifts"
    case greetingCards = "greeting cards"
    case letterboxGifts = "letterbox gifts"
    case mugs = "mugs"
    case tShirts = "t-shirts"
}
