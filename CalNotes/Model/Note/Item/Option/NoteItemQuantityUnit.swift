//
//  NoteItemQuantityUnit.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-11-04.
//

enum NoteItemQuantityUnit: Int {
    case kilogram
    case litre
}

extension NoteItemQuantityUnit {
    var name: String {
        switch self {
        case .kilogram:
            return "kg"
        case .litre:
            return "L"
        }
    }

    static func unit(from name: String) -> NoteItemQuantityUnit? {
        return NoteItemQuantityUnit.allCases.first { $0.name == name }
    }
}

// MARK: - PickerItem
extension NoteItemQuantityUnit: CaseIterable {
    static var items: [PickerItem] {
        return allCases.map { item in
            PickerItem(id: item.rawValue, value: item.name)
        }
    }
}

