//
//  Dimen+float.swift
//  TWC
//
//  Created by Jacky Lam on 14/12/2021.
//

import UIKit

extension Dimen {
    func float(_ float: Float) -> CGFloat {
        return float.rawValue
    }
}

extension Dimen {
    static func float(_ float: Float) -> CGFloat {
        return shared.float(float)
    }
}

extension Dimen {
    enum Float {
        case shadowAlpha
        case shadowOffsetX
        case shadowOffsetY
        case iconSmallWidth
        case iconWidth
        case iconLargeWidth
        case iconXLargeWidth
        case iconXXLargeWidth
        case logoWidth
        case textEditorHeight
        case imagePickerHeight
        
        var rawValue: CGFloat {
            switch self {
            case .shadowAlpha:
                return 0.5
            case .shadowOffsetX:
                return 2
            case .shadowOffsetY:
                return 2
            case .iconSmallWidth:
                return 16
            case .iconWidth:
                return 24
            case .iconLargeWidth:
                return 32
            case .iconXLargeWidth:
                return 48
            case .iconXXLargeWidth:
                return 72
            case .logoWidth:
                return 192
            case .textEditorHeight:
                return 100
            case .imagePickerHeight:
                return 175
            }
        }
    }
}
