//
//  NoteDetail.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Foundation

struct NoteDetail: Record {
    var id: Int
    var title: String
    var items: [NoteItem]
    var sum: Float
    var lastUpdate: String
    var disabled: Bool
}

extension NoteDetail {
    static var none: NoteDetail {
        return NoteDetail(
            id: 0,
            title: "",
            items: [],
            sum: 0,
            lastUpdate: "",
            disabled: false
        )
    }
}

