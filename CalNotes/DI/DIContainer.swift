//
//  DIContainer.swift
//  TWC
//
//  Created by Jacky on 15/10/2021.
//

import SwiftUI
import Combine

class DIContainer: EnvironmentKey {
    static var defaultValue = DIContainer()
    let dataService: DataService = DataSession.shared
}

// MARK: - EnvironmentValues
extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
