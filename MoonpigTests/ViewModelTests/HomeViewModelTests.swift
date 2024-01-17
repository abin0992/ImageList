//
//  HomeViewModelTests.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import XCTest
@testable import Moonpig

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockFetchHomeProductListUseCase: MockFetchHomeProductListUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockFetchHomeProductListUseCase = MockFetchHomeProductListUseCase()
        viewModel = HomeViewModel(fetchHomeProductListUseCase: mockFetchHomeProductListUseCase)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockFetchHomeProductListUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testViewModelInitialStateIsLoading() {
        XCTAssertEqual(viewModel.state, .loading)
    }

    func testViewModelFetchesProductsOnInitialization() {
        let expectation = XCTestExpectation(description: "Fetch products on initialization")

        viewModel.$state
            .dropFirst() // Drop the initial loading state
            .sink { state in
                if case .data(let products) = state {
                    XCTAssertEqual(products.count, self.mockFetchHomeProductListUseCase.stubbedProducts.count)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockFetchHomeProductListUseCase.sendProducts()

        wait(for: [expectation], timeout: 1.0)
    }

    func testViewModelHandlesErrorState() {
        let expectation = XCTestExpectation(description: "Handle error state")

        viewModel.$state
            .dropFirst() // Drop the initial loading state
            .sink { state in
                if case .error(let error) = state {
                    XCTAssertEqual(error, ClientError.generic)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockFetchHomeProductListUseCase.sendError()

        wait(for: [expectation], timeout: 1.0)
    }

    func testViewModelRetryFetchesProducts() {
        let expectation = XCTestExpectation(description: "Retry fetches products")

        // Simulate an error first
        mockFetchHomeProductListUseCase.sendError()

        // Then retry
        viewModel.didTapRetry.send()

        viewModel.$state
            .sink { state in
                if case .data(let products) = state {
                    XCTAssertEqual(products.count, self.mockFetchHomeProductListUseCase.stubbedProducts.count)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockFetchHomeProductListUseCase.sendProducts()

        wait(for: [expectation], timeout: 1.0)
    }
}
