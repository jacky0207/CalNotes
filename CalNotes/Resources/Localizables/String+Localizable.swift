//
//  String+Localizable.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: "**\(self)**", comment: "")
    }

    func localized(with arguments: [CVarArg]) -> String {
        return String(format: localized(), arguments: arguments)
    }
}
