//
//  Dimen+Spacing.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import UIKit

extension Dimen {
    func spacing(_ spacing: Spacing) -> CGFloat {
        return spacing.rawValue
    }
}

extension Dimen {
    static func spacing(_ spacing: Spacing) -> CGFloat {
        return shared.spacing(spacing)
    }
}

extension Dimen {
    enum Spacing {
        // common
        case xSmall
        case small
        case normal
        case large
        case xLarge
        case xxLarge
        // screen
        case topMargin
        case horizontalMargin
        case bottomMargin
        // component
        case verticalRow

        var rawValue: CGFloat {
            switch self {
            case .xSmall:
                return 4
            case .small:
                return 8
            case.normal:
                return 12
            case .large:
                return 16
            case .xLarge:
                return 20
            case .xxLarge:
                return 24
            case .topMargin:
                return 10
            case .horizontalMargin:
                return 16
            case .bottomMargin:
                return 50
            case .verticalRow:
                return 10
            }
        }
    }
}
