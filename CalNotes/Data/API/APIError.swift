//
//  APIError.swift
//  NASA Data
//
//  Created by Jacky Lam on 2023-08-09.
//

struct APIError: Decodable {
    var error: Error
}

extension APIError {
    struct Error: Decodable {
        var code: String
        var message: String
    }
}
