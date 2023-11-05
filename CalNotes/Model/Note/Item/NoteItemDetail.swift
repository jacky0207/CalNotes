//
//  NoteItemDetail.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

struct NoteItemDetail: RecordItem {
    var id: Int
    var noteId: Int
    var title: String
    var category: Int
    var amount: Float
    var quantity: Float?
    var quantityUnit: String?
    var image: Data?
    var remarks: String?
}

extension NoteItemDetail {
    static var none: NoteItemDetail {
        return NoteItemDetail(
            id: 0,
            noteId: 0,
            title: "",
            category: 0,
            amount: 0.0
        )
    }
}
