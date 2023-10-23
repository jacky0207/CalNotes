//
//  Dimen+Corner.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import UIKit

extension Dimen {
    func corner(_ corner: Corner) -> CGFloat {
        return corner.rawValue
    }
}

extension Dimen {
    static func corner(_ corner: Corner) -> CGFloat {
        return shared.corner(corner)
    }

}

extension Dimen {
    enum Corner: CGFloat {
        case small = 6
        case normal = 10
        case large = 14
        case xLarge = 18
        case xxLarge = 22
    }
}
