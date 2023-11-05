//
//  NoteItemList.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-30.
//

import Foundation

struct NoteItemList: Decodable {
    var items: [NoteItem]
}

extension NoteItemList {
    static var none: NoteItemList {
        return NoteItemList(items: [])
    }
}
