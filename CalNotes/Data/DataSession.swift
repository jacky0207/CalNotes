//
//  DataSession.swift
//  TWC
//
//  Created by Jacky on 15/10/2021.
//

import Combine
import CoreData

struct DataSession: DataService {
    static var shared = DataSession()
    var localService: LocalService = LocalSession.shared

    mutating func deleteAll() -> AnyPublisher<Void, DataError<APIError>> {
        return localService.deleteAll()
    }

    func getHome() -> AnyPublisher<Home, DataError<APIError>> {
        return localService.getHome()
    }

    func getAllNotes() -> AnyPublisher<NoteList, DataError<APIError>> {
        return localService.getAllNotes()
    }

    func getAllDisabledNotes() -> AnyPublisher<NoteList, DataError<APIError>> {
        return localService.getAllDisabledNotes()
    }

    func createNote(form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.createNote(form: form)
    }

    func cloneNote(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.cloneNote(noteId: noteId)
    }

    func editNoteTitle(noteId: Int, form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.editNoteTitle(noteId: noteId, form: form)
    }

    func deleteNote(noteId: Int) -> AnyPublisher<NoteList, DataError<APIError>> {
        return localService.deleteNote(noteId: noteId)
    }

    func deleteAllDisabledNote() -> AnyPublisher<NoteList, DataError<APIError>> {
        return localService.deleteAllDisabledNote()
    }

    func recoverNote(noteId: Int) -> AnyPublisher<NoteList, DataError<APIError>> {
        return localService.recoverNote(noteId: noteId)
    }

    func getNoteDetail(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.getNoteDetail(noteId: noteId)
    }

    func addNoteItem(noteId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        return localService.addNoteItem(noteId: noteId, form: form)
    }

    func cloneNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.cloneNoteItem(noteId: noteId, noteItemId: noteItemId)
    }

    func updateNoteItem(noteId: Int, noteItemId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        return localService.updateNoteItem(noteId: noteId, noteItemId: noteItemId, form: form)
    }

    func deleteNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.deleteNoteItem(noteId: noteId, noteItemId: noteItemId)
    }

    func moveNoteItem(noteId: Int, noteItemId: Int, newNoteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        return localService.moveNoteItem(noteId: noteId, noteItemId: noteItemId, newNoteItemId: newNoteItemId)
    }

    func getNoteItemDetail(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        return localService.getNoteItemDetail(noteId: noteId, noteItemId: noteItemId)
    }
}
