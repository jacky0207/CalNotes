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

extension NoteItemList: Encodable & CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension NoteItemList {
    static var none: NoteItemList {
        return NoteItemList(items: [])
    }
}
