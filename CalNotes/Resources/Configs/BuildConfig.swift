//
//  BuildConfig.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import Foundation

struct BuildConfig {
    static let shared = BuildConfig()

    private init() {}

    func string(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }

    func bool(for key: String) -> Bool {
        Bundle.main.infoDictionary?[key] as! Bool
    }

    func int(for key: String) -> Int {
        Bundle.main.infoDictionary?[key] as! Int
    }

    func float(for key: String) -> CGFloat {
        Bundle.main.infoDictionary?[key] as! CGFloat
    }
}
