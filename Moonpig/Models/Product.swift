//
//  Product.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let price: Price
    let soldOut: Int
    let title: String
    let productCategory: ProductCategory
    let cardShopID: Int
    let photoUploadCount: Int
    let directSmile: Bool
    let defaultSizeID, productID: Int
    let moonpigProductNo: String
    let tradingFaces: Int
    let isLandscape: Int
    let shortDescription: String
    let description: String
    let isCustomisable: Int
    let isMultipack: Int
    let seoPath: String
    let productLink: ImageLink
    let productImage: ProductImage
    let reviews: Reviews
    let additionalProductImages: [ProductImage]

    enum CodingKeys: String, CodingKey {
        case price = "Price"
        case soldOut = "SoldOut"
        case title = "Title"
        case productCategory = "ProductCategory"
        case photoUploadCount = "PhotoUploadCount"
        case cardShopID = "CardShopId"
        case directSmile = "DirectSmile"
        case defaultSizeID = "DefaultSizeId"
        case productID = "ProductId"
        case moonpigProductNo = "MoonpigProductNo"
        case tradingFaces = "TradingFaces"
        case isLandscape = "IsLandscape"
        case shortDescription = "ShortDescription"
        case description = "Description"
        case isCustomisable = "IsCustomisable"
        case isMultipack = "IsMultipack"
        case seoPath = "SeoPath"
        case productLink = "ProductLink"
        case productImage = "ProductImage"
        case reviews = "Reviews"
        case additionalProductImages = "AdditionalProductImages"
    }
}
