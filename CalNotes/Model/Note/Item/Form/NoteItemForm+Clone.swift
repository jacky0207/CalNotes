//
//  NoteItemForm+Clone.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-14.
//

extension NoteItemForm {
    init(cdNoteItem: CDNoteItem) {
        self.init(
            category: Int(cdNoteItem.category),
            title: cdNoteItem.title,
            amount: cdNoteItem.amount,
            quantity: cdNoteItem.quantity,
            image: cdNoteItem.image,
            remarks: cdNoteItem.remarks
        )
    }
}
