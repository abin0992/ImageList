//
//  MockHomeProductListFetchable.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation
@testable import Moonpig

class MockFetchHomeProductListUseCase: HomeProductListFetchable {
    var stubbedProducts: [ProductViewModel] = []
    var stubbedError: Error? = nil
    private let subject = PassthroughSubject<DomainResult<[ProductViewModel]>, Never>()

    func execute() -> AnyPublisher<DomainResult<[ProductViewModel]>, Never> {
        return subject.eraseToAnyPublisher()
    }

    func sendProducts() {
        subject.send(.success(stubbedProducts))
    }

    func sendError() {
        let error = stubbedError ?? ClientError.generic
        subject.send(.error(error))
    }
}
