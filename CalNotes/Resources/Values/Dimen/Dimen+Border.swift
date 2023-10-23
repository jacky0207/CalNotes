//
//  Dimen+Border.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-29.
//

import UIKit

extension Dimen {
    func border(_ border: Border) -> CGFloat {
        return border.rawValue
    }
}

extension Dimen {
    static func border(_ border: Border) -> CGFloat {
        return shared.border(border)
    }

}

extension Dimen {
    enum Border: CGFloat {
        case small = 1
        case normal = 1.5
        case large = 2
    }
}
