//
//  Note.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Foundation

struct Note: Record & Hashable {
    var id: Int
    var title: String
    var sum: Float
    var lastUpdate: String
}

extension Note {
    static var none: Note {
        return Note(
            id: 0,
            title: "",
            sum: 0.0,
            lastUpdate: ""
        )
    }
}
