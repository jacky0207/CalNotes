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

extension NoteList {
    static var none: NoteList {
        return NoteList(notes: [])
    }
}
