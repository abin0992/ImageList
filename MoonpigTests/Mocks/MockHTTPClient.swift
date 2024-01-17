//
//  MockHTTPClient.swift
//  MoonpigTests
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation
@testable import Moonpig

class MockHTTPClient: HTTPClientProtocol {
    var requestHandler: ((URL) -> AnyPublisher<Data, Error>)?

    func performRequest<T>(url: URL) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        guard let handler = requestHandler else {
            return Fail(error: ClientError.invalidURL).eraseToAnyPublisher()
        }
        return handler(url)
            .flatMap { data -> AnyPublisher<T, Error> in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .catch { _ in Fail(error: URLError(.cannotDecodeContentData)) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


