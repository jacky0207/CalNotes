//
//  LocalSession.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Combine
import CoreData

struct LocalSession: LocalService {
    static let shared = LocalSession()
    private var coreDataHelper = CoreDataHelper.shared

    mutating func deleteAll() -> AnyPublisher<Void, DataError<APIError>> {
        do {
            try coreDataHelper.deleteAll()
            return Just(())
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func getAllNotes() -> AnyPublisher<NoteList, DataError<APIError>> {
        do {
            let cdNotes = try coreDataHelper.notes()
            let cdNoteItems = try coreDataHelper.noteItems()
            let noteList = NoteList(cdNotes: cdNotes, cdNoteItems: cdNoteItems)
            print("Response=\(noteList)")
            return Just(noteList)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func createNote(form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={form:\(form)}")
            let cdNote = try coreDataHelper.createNote(form: form)
            let noteDetail = NoteDetail(cdNote: cdNote, cdNoteItems: [])
            print("Response=\(noteDetail)")
            return Just(noteDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func cloneNote(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId)}")
            let cdNote = try coreDataHelper.cloneNote(noteId: noteId)
            let cdNoteItems = try coreDataHelper.noteItems(noteId: Int(cdNote.id))
            let noteDetail = NoteDetail(cdNote: cdNote, cdNoteItems: cdNoteItems)
            print("Response=\(noteDetail)")
            return Just(noteDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func editNoteTitle(noteId: Int, form: CreateNoteForm) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={form:\(form)}")
            try coreDataHelper.editNoteTitle(noteId: noteId, form: form)
            return getNoteDetail(noteId: noteId)
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func deleteNote(noteId: Int) -> AnyPublisher<NoteList, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId)}")
            try coreDataHelper.deleteNote(noteId: noteId)
            try coreDataHelper.deleteNoteItems(noteId: noteId)
            return getAllNotes()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func getNoteDetail(noteId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId)}")
            let cdNote = try coreDataHelper.note(noteId: noteId)
            let cdNoteItems = try coreDataHelper.noteItems(noteId: noteId)
            let noteDetail = NoteDetail(cdNote: cdNote, cdNoteItems: cdNoteItems)
            print("Response=\(noteDetail)")
            return Just(noteDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func addNoteItem(noteId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),form:\(form)}")
            let cdNoteItem = try coreDataHelper.createNoteItem(noteId: noteId, form: form)
            let noteItemDetail = NoteItemDetail(cdNoteItem: cdNoteItem)
            print("Response=\(noteItemDetail)")
            return Just(noteItemDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func cloneNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),noteItemId:\(noteItemId)}")
            _ = try coreDataHelper.cloneNoteItem(noteId: noteId, noteItemId: noteItemId)
            return getNoteDetail(noteId: noteId)
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func updateNoteItem(noteId: Int, noteItemId: Int, form: NoteItemForm) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),noteItemId:\(noteItemId),form:\(form)}")
            let cdNoteItem = try coreDataHelper.updateNoteItem(noteId: noteId, noteItemId: noteItemId, form: form)
            let noteItemDetail = NoteItemDetail(cdNoteItem: cdNoteItem)
            print("Response=\(noteItemDetail)")
            return Just(noteItemDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func deleteNoteItem(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),noteItemId:\(noteItemId)}")
            try coreDataHelper.deleteNoteItem(noteId: noteId, noteItemId: noteItemId)
            return getNoteDetail(noteId: noteId)
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func moveNoteItem(noteId: Int, noteItemId: Int, newNoteItemId: Int) -> AnyPublisher<NoteDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),noteItemId:\(noteItemId),newNoteItemId:\(newNoteItemId)}")
            try coreDataHelper.moveNoteItem(noteId: noteId, noteItemId: noteItemId, newNoteItemId: newNoteItemId)
            return getNoteDetail(noteId: noteId)
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }

    func getNoteItemDetail(noteId: Int, noteItemId: Int) -> AnyPublisher<NoteItemDetail, DataError<APIError>> {
        do {
            print("Request={noteId:\(noteId),noteItemId:\(noteItemId)}")
            let cdNoteItem = try coreDataHelper.noteItem(noteId: noteId, noteItemId: noteItemId)
            let noteItemDetail = NoteItemDetail(cdNoteItem: cdNoteItem)
            print("Response=\(noteItemDetail)")
            return Just(noteItemDetail)
                .setFailureType(to: DataError<APIError>.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: DataError.local(.unknown))
                .eraseToAnyPublisher()
        }
    }
}
