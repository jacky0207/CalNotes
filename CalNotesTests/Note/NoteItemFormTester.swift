//
//  NoteItemFormTester.swift
//  CalNotesTests
//
//  Created by Jacky Lam on 2023-11-05.
//

@testable import CalNotes

struct NoteItemFormTester {
    var form: NoteItemForm.LocalForm = .none

    mutating func reset() {
        form = .none
    }

    mutating func fillInDollarForm() {
        form = NoteItemForm.LocalForm(
            category: .init(NoteItemCategory.dollar.rawValue),
            title: .init("title"),
            amount: .init("1"),
            quantity: .init("1"),
            quantityUnit: .init(-1),
            image: .init(nil),
            remarks: .init("")
        )
    }

    mutating func fillInTransportationForm() {
        form = NoteItemForm.LocalForm(
            category: .init(NoteItemCategory.transport.rawValue),
            title: .init("title"),
            amount: .init("1"),
            quantity: .init(""),
            quantityUnit: .init(-1),
            image: .init(nil),
            remarks: .init("")
        )
    }
}
