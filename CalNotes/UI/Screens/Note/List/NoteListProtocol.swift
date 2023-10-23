//
//  NoteListProtocol.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

protocol NoteListProtocol {
    var list: NoteList { get set }
    var selectedNoteId: Int { get set }
    func getAllNotes()
    func createNote(form: CreateNoteForm, completion: @escaping (NoteDetail) -> Void)
    func deleteNote(noteId: Int)
    func deleteNote(at index: Int)
    func cloneNote(noteId: Int, completion: @escaping (NoteDetail) -> Void)
    func cloneNote(at index: Int, completion: @escaping (NoteDetail) -> Void)
}
