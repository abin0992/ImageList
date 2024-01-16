//
//  Reviews.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

// MARK: - Reviews
struct Reviews: Codable {
    let minReviewData: Int?
    let maxReviewData: Int?
    let averageStarReviewRating: Double?
    let reviewCount: Int

    enum CodingKeys: String, CodingKey {
        case minReviewData = "MinReviewData"
        case maxReviewData = "MaxReviewData"
        case averageStarReviewRating = "AverageStarReviewRating"
        case reviewCount = "ReviewCount"
    }
}
