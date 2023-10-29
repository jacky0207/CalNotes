//
//  NoteTrashProtocol.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-28.
//

protocol NoteTrashProtocol {
    var list: NoteList { get set }
    func getAllNotes()
    func deleteNote(noteId: Int)
    func deleteNote(at index: Int)
    func deleteAllDisabledNotes()
    func recoverNote(noteId: Int)
    func recoverNote(at index: Int)
}
