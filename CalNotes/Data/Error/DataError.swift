//
//  DataError.swift
//  TWC
//
//  Created by Jacky on 11/10/2021.
//

import Combine
import Foundation

enum DataError<T: Decodable>: Error {
    case server(T, HTTPURLResponse)
    case local(LocalError)
}

extension DataError where T == APIError {
    var errorMessage: String {
        switch self {
        case .server(let error, _):
            return error.error.message
        case .local(let error):
            return error.localizedDescription
        }
    }
}
