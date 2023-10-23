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
}

extension NoteDetail: Encodable & CustomStringConvertible {
    var description: String {
        var object = self
        for i in object.items.indices {
            object.items[i].image = Data()
        }
        let jsonData = try! JSONEncoder().encode(object)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension NoteDetail {
    static var none: NoteDetail {
        return NoteDetail(
            id: 0,
            title: "",
            items: [],
            sum: 0,
            lastUpdate: ""
        )
    }
}

