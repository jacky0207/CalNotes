//
//  Dimen.swift
//  TWC
//
//  Created by Jacky on 20/10/2021.
//

import UIKit

struct Dimen {
    static let shared = Dimen()

    private let screenScaled = false
    private let minScreenWidth = 375.0
    
    private init() {}
    
    func dimen(_ dimen: CGFloat) -> CGFloat {
        return screenScaled ? dimen * UIScreen.screenWidth / minScreenWidth : dimen
    }
}

extension Dimen {
    static func dimen(_ dimen: CGFloat) -> CGFloat {
        return shared.dimen(dimen)
    }
}
