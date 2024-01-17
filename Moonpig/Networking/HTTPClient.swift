//
//  HTTPClient.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Combine
import Foundation

protocol HTTPClientProtocol {
    func performRequest<T: Codable>(url: URL) -> AnyPublisher<T, Error>
}

class HTTPClient: HTTPClientProtocol {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func performRequest<T: Codable>(url: URL) -> AnyPublisher<T, Error> {

        var request = URLRequest(url: url)
        // TODO: Add support for "POST", "PUT", etc.
        request.httpMethod = "GET"

        return session.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
