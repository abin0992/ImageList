//
//  MockHomeProductListUseCase.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation

class PreviewHomeProductListUseCase: HomeProductListFetchable {
    func execute() -> AnyPublisher<DomainResult<[ProductViewModel]>, Never> {
        // Create some sample data to return
        let sampleProducts = [
            ProductViewModel(
                id: 1,
                imageURL: "https://example.com/image1.png"
            ),
            ProductViewModel(
                id: 2,
                imageURL: "https://example.com/image2.png"
            )
        ]

        return Just(sampleProducts)
            .map(DomainResult<[ProductViewModel]>.success)
            .eraseToAnyPublisher()
    }
}
