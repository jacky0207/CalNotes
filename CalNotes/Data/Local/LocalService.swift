//
//  LocalService.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Combine
import CoreData

protocol LocalService {
    mutating func deleteAll() -> AnyPublisher<Void, DataError<APIError>>
    // Note
    func getAllNotes() -> AnyPublisher<NoteList, DataError<APIError>>
    func getAllDisabledNotes() -> AnyPublisher<NoteList, DataError<APIError>>
    func createNote(form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func cloneNote(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func editNoteTitle(noteId: Int, form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func deleteNote(noteId: Int) -> AnyPublisher<NoteList, DataError<APIError>>
    func deleteAllDisabledNote() -> AnyPublisher<NoteList, DataError<APIError>>
    func recoverNote(noteId: Int) -> AnyPublisher<NoteList, DataError<APIError>>
    func getNoteDetail(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>>
    // NoteItem
    func addNoteItem(noteId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>>
    func cloneNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func updateNoteItem(noteId: Int, noteItemId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>>
    func deleteNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func moveNoteItem(noteId: Int, noteItemId: Int, newNoteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>>
    func getNoteItemDetail(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteItemDetail, DataError<APIError>>
}
