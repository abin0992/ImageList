//
//  ProductService.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation

protocol ProductFetchable {
    func fetchProducts() -> AnyPublisher<HomeProductList, Error>
}

class ProductService: ProductFetchable {

    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    func fetchProducts() -> AnyPublisher<HomeProductList, Error> {
        guard let url = URL(string: "https://moonpig.github.io/tech-test-frontend/search.json") else {
            return Fail<HomeProductList, Error>(error: ClientError.invalidURL)
                .eraseToAnyPublisher()
        }
        return httpClient.performRequest(url: url)
    }
}
