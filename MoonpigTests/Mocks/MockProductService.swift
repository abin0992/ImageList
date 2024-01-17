//
//  MockProductService.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation
@testable import Moonpig

class MockProductService: ProductFetchable {
    var stubbedFetchDataResult: AnyPublisher<HomeProductList, Error>!

    func fetchProducts() -> AnyPublisher<HomeProductList, Error> {
        return stubbedFetchDataResult
    }
}
