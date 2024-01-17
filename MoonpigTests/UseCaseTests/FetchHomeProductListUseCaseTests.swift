//
//  FetchHomeProductListUseCaseTests.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import XCTest
@testable import Moonpig

class FetchHomeProductListUseCaseTests: XCTestCase {

    private var mockProductService: MockProductService!
    private var fetchHomeProductListUseCase: FetchHomeProductListUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        fetchHomeProductListUseCase = FetchHomeProductListUseCase(productService: mockProductService)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        mockProductService = nil
        fetchHomeProductListUseCase = nil
        super.tearDown()
    }

    func testExecuteSuccess() {
        // Given
        let productList: HomeProductList = TestUtilities.load(fromJSON: "expectedProducts", type: HomeProductList.self)
        let responsePublisher = Just(productList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        mockProductService.stubbedFetchDataResult = responsePublisher

        // When
        let expectation = XCTestExpectation(description: "execute should return success with product view models")
        fetchHomeProductListUseCase.execute()
            .sink(receiveValue: { domainResult in
                if case .success(let productViewModels) = domainResult {
                    XCTAssertEqual(productViewModels.count, productList.products.count)
                    XCTAssertEqual(productViewModels.first?.id, productList.products.first?.productID)
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func testExecuteFailure() {
        // Given
        let responsePublisher = Fail<HomeProductList, Error>(error: ClientError.networkError)
            .eraseToAnyPublisher()
        mockProductService.stubbedFetchDataResult = responsePublisher

        // When
        let expectation = XCTestExpectation(description: "execute should return error")
        fetchHomeProductListUseCase.execute()
            .sink(receiveValue: { domainResult in
                if case .error(let error) = domainResult, case ClientError.networkError = error {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
