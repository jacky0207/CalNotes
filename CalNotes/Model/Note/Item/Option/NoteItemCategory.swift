//
//  NoteItemCategory.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

enum NoteItemCategory: Int, CaseIterable {
    case dollar
    case food
    case transport
    case rent
    case cellPhone
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
            return ""
        case .transport:
            return "transport".localized()
        case .rent:
            return "rent".localized()
        case .cellPhone:
            return "cellPhone".localized()
        case .insurance:
            return "insurance".localized()
        }
    }
}

extension NoteItemCategory {
    var isQuantityEnabled: Bool {
        switch self {
        case .dollar:
            return true
        case .food:
            return true
        case .transport:
            return false
        case .rent:
            return false
        case .cellPhone:
            return false
        case .insurance:
            return false
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
