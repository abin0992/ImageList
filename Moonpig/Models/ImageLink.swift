//
//  ImageLink.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - Link
struct ImageLink: Codable {
    let imageURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "Href"
        case title = "Title"
    }
}
