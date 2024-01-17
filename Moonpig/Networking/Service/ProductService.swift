//
//  ProductService.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation

class ProductService: ProductFetchable {

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func fetchData() -> AnyPublisher<HomeProductList, Error> {
        // TODO: Better approach for generating URL without force unwrapping, return custom error for invalid URL
        guard let url = URL(string: "https://moonpig.github.io/tech-test-frontend/search.json") else {
            return Fail<HomeProductList, Error>(error: ClientError.invalidURL)
                .eraseToAnyPublisher()
        }
        return httpClient.performRequest(url: url)
    }
}

protocol ProductFetchable {
    func fetchData() -> AnyPublisher<HomeProductList, Error>
}
