//
//  NoteDetailProtocol.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import Foundation

protocol NoteDetailProtocol {
    var id: Int { get set }
    var note: NoteDetail { get set }
    init(diContainer: DIContainer, id: Int)
    func getNoteDetail()
    func editNoteTitle(form: CreateNoteForm)
    func deleteNoteItem(noteItemId: Int)
    func deleteNoteItem(at index: Int)
    func moveNoteItem(noteItemId: Int, newNoteItemId: Int) async
    func moveNoteItem(from source: IndexSet, to destination: Int) async
    func cloneNoteItem(noteItemId: Int)
    func cloneNoteItem(at index: Int)
}
