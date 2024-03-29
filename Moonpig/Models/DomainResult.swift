//
//  DomainResult.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Foundation

enum DomainResult<T> {

    case success(T)
    case error(Error)

    var value: T? {
        guard case let .success(value) = self else {
            return nil
        }
        return value
    }

    var error: Error? {
        guard case let .error(error) = self else {
            return nil
        }

        return error
    }
}
