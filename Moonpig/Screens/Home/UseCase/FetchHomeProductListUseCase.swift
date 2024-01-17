//
//  FetchHomeProductListUseCase.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation

class FetchHomeProductListUseCase: HomeProductListFetchable {

    private let productService: ProductFetchable

    init(productService: ProductFetchable) {
        self.productService = productService
    }

    func execute() -> AnyPublisher<DomainResult<[ProductViewModel]>, Never> {
        productService.fetchData()
            .map { productList in
                productList.products.map { product in
                    ProductViewModel(
                        id: product.productID,
                        imageURL: product.productImage.imageLink.imageURL
                    )
                }
            }
            .map(DomainResult<[ProductViewModel]>.success)
            .catch { error in
                Just(.error(error))
            }
            .eraseToAnyPublisher()
    }
}

protocol HomeProductListFetchable {
    func execute() -> AnyPublisher<DomainResult<[ProductViewModel]>, Never>
}
