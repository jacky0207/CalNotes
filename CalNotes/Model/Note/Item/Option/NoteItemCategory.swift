//
//  NoteItemCategory.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

enum NoteItemCategory: Int, CaseIterable {
    case dollar
    // eating
    case food
    // transport
    case transport
    // living
    case rent
    case water
    case heat
    case hydro
    case internet
    // communication
    case cellPhone
    // insurance
    case insurance
}

extension NoteItemCategory {
    var icon: Image {
        switch self {
        case .dollar:
            return Image("dollar")
        case .food:
            return Image("food")
        case .transport:
            return Image("bus")
        case .rent:
            return Image("house")
        case .water:
            return Image("water")
        case .heat:
            return Image("heat")
        case .hydro:
            return Image("hydro")
        case .internet:
            return Image("internet")
        case .cellPhone:
            return Image("smartphone")
        case .insurance:
            return Image("insurance")
        }
    }
    
    var name: String {
        switch self {
        case .dollar:
            return ""
        case .food:
            return "food".localized()
        case .transport:
            return "transport".localized()
        case .rent:
            return "rent".localized()
        case .water:
            return "water".localized()
        case .heat:
            return "heat".localized()
        case .hydro:
            return "hydro".localized()
        case .internet:
            return "internet".localized()
        case .cellPhone:
            return "cellPhone".localized()
        case .insurance:
            return "insurance".localized()
        }
    }
}

// MARK: - PickerItem
extension NoteItemCategory {
    static var items: [PickerItem] {
        return allCases.map { item in
            PickerItem(id: item.rawValue, value: String(describing: item).capitalized)
        }
    }
}
