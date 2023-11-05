//
//  CDNote+Note.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-01.
//

import CoreData

extension CDNoteItem {
    var sum: Float {
        return amount * quantity
    }
}

extension Note {
    init(cdNote: CDNote, cdNoteItems: [CDNoteItem]) {
        self.init(
            id: Int(cdNote.id),
            title: cdNote.title,
            sum: cdNoteItems.reduce(0, { $0 + $1.sum }),
            lastUpdate: cdNote.lastUpdate
        )
    }
}

extension NoteList {
    init(cdNotes: [CDNote], cdNoteItems: [CDNoteItem]) {
        let cdNoteItemGroups = [Int: [CDNoteItem]](grouping: cdNoteItems, by: { Int($0.noteId) })
        let notes = cdNotes.map {
            Note(
                cdNote: $0,
                cdNoteItems: cdNoteItemGroups[Int($0.id)] ?? []
            )
        }
        self.init(notes: notes)
    }
}

extension NoteDetail {
    init(cdNote: CDNote, cdNoteItems: [CDNoteItem]) {
        self.init(
            id: Int(cdNote.id),
            title: cdNote.title,
            items: cdNoteItems.map { NoteItem(cdNoteItem: $0) },
            sum: cdNoteItems.reduce(0, { $0 + $1.sum }),
            lastUpdate: cdNote.lastUpdate,
            disabled: cdNote.disabled
        )
    }
}
