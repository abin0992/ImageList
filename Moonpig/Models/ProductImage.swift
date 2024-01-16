//
//  ProductImage.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - ProductImage
struct ProductImage: Codable {
    let imageLink: ImageLink

    enum CodingKeys: String, CodingKey {
        case imageLink = "Link"
    }
}
