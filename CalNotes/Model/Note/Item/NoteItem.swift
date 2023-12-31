//
//  NoteItem.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Foundation

struct NoteItem: RecordItem & Hashable {
    var id: Int
    var noteId: Int
    var title: String
    var category: Int
    var amount: Float
    var quantity: Float
    var quantityUnit: String?
    var sum: Float
    var image: Data?
    var remarks: String?
}

extension NoteItem {
    static var none: NoteItem {
        return NoteItem(
            id: 0,
            noteId: 0,
            title: "",
            category: 0,
            amount: 0.0,
            quantity: 1,
            sum: 0.0
        )
    }
}
