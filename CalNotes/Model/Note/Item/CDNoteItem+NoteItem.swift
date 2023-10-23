//
//  CDNoteItem+NoteItem.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-01.
//

import Foundation
import CoreData

// MARK: - NoteItem
extension NoteItem {
    init(cdNoteItem: CDNoteItem) {
        self.init(
            id: Int(cdNoteItem.id),
            noteId: Int(cdNoteItem.noteId),
            title: cdNoteItem.title,
            category: Int(cdNoteItem.category),
            amount: Float(cdNoteItem.amount),
            image: cdNoteItem.image,
            remarks: cdNoteItem.remarks
        )
    }
}

// MARK: - NoteItemDetail
extension NoteItemDetail {
    init(cdNoteItem: CDNoteItem) {
        self.init(
            id: Int(cdNoteItem.id),
            noteId: Int(cdNoteItem.noteId),
            title: cdNoteItem.title,
            category: Int(cdNoteItem.category),
            amount: Float(cdNoteItem.amount),
            image: cdNoteItem.image,
            remarks: cdNoteItem.remarks
        )
    }
}

extension CDNoteItem {
    func update(form: NoteItemForm) {
        self.title = form.title
        self.category = Int16(form.category)
        self.amount = form.amount
        self.image = form.image
        self.remarks = form.remarks
    }
}
