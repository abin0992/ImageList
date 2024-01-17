//
//  ProductServiceTests.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import XCTest
@testable import Moonpig

class ProductServiceTests: XCTestCase {
    var productService: ProductService!
    var mockHTTPClient: MockHTTPClient!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockHTTPClient = MockHTTPClient()
        productService = ProductService(httpClient: mockHTTPClient)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        mockHTTPClient = nil
        productService = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        // Given
        let expectedProducts: HomeProductList = TestUtilities.load(fromJSON: "expectedProducts", type: HomeProductList.self)
        guard let data = try? JSONEncoder().encode(expectedProducts) else { return }
        mockHTTPClient.requestHandler = { _ in
            Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        // When
        let expectation = XCTestExpectation(description: "fetchProducts completes")
        productService.fetchProducts()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected successful fetch, got error")
                }
            }, receiveValue: { productList in
                XCTAssertEqual(productList.products.count, expectedProducts.products.count)
                XCTAssertEqual(productList.products.first?.productID, expectedProducts.products.first?.productID)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchProductsFailure() {
        // Given
        let error = URLError(.badServerResponse)
        mockHTTPClient.requestHandler = { _ in
            Fail<Data, Error>(error: error)
                .eraseToAnyPublisher()
        }

        // When
        let expectation = XCTestExpectation(description: "fetchProducts fails")
        productService.fetchProducts()
            .sink(receiveCompletion: { completion in
                if case let .failure(receivedError as URLError) = completion {
                    XCTAssertEqual(receivedError.code, error.code)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure with URLError, got \(completion)")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, got value")
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchProductsWithInvalidURL() {
        // Given
        // productService is already initialized with a mockHTTPClient in setUp()
        // We don't need to set up a requestHandler because the URL is invalid and the request should not be made.

        // When
        let expectation = XCTestExpectation(description: "fetchProducts with invalid URL fails")
        productService.fetchProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error as ClientError):
                    XCTAssertEqual(error, ClientError.invalidURL)
                    expectation.fulfill()
                default:
                    XCTFail("Expected failure with ClientError.invalidURL, got \(completion)")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, got value")
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

}
