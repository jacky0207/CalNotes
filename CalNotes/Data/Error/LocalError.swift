//
//  LocalError.swift
//  TWC
//
//  Created by Jacky on 22/10/2021.
//

import Foundation
    
enum LocalError {
    case disconnected
    case decode
    case unknown
    case notFound
}

extension LocalError {
    var localizedDescription: String {
        return String(describing: self)
    }
}
