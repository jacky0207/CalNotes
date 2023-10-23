//
//  NoteList.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-30.
//

import Foundation

struct NoteList: Decodable {
    var notes: [Note]
}

extension NoteList: Encodable & CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension NoteList {
    static var none: NoteList {
        return NoteList(notes: [])
    }
}
