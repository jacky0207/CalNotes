//
//  CoreDataHelper.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-04.
//

import CoreData

protocol CoreDataHelperProtocol {
    mutating func deleteAll() throws
    // note
    func notes() throws -> [CDNote]
    func disabledNotes() throws -> [CDNote]
    func note(noteId: Int) throws -> CDNote
    func nextNoteId() throws -> Int16
    func newNote(form: CreateNoteForm) throws -> CDNote
    func createNote(form: CreateNoteForm) throws -> CDNote
    func cloneNote(noteId: Int) throws -> CDNote
    func editNoteTitle(noteId: Int, form: CreateNoteForm) throws
    func updateNoteLastUpdate(noteId: Int) throws
    func deleteNote(noteId: Int) throws
    func deleteAllDisabledNotes() throws
    func recoverNote(noteId: Int) throws
    // note item
    func noteItems() throws -> [CDNoteItem]
    func noteItems(noteId: Int) throws -> [CDNoteItem]
    func noteItem(noteId: Int, noteItemId: Int) throws -> CDNoteItem
    func nextNoteItemId(noteId: Int) throws -> Int16
    func newNoteItem(noteId: Int, form: NoteItemForm) throws -> CDNoteItem
    func createNoteItem(noteId: Int, form: NoteItemForm) throws -> CDNoteItem
    func cloneNoteItem(noteId: Int, noteItemId: Int) throws -> CDNoteItem
    func updateNoteItem(noteId: Int, noteItemId: Int, form: NoteItemForm) throws -> CDNoteItem
    func copyNoteItems(from oldNoteId: Int, to newNoteId: Int) throws -> [CDNoteItem]
    func deleteNoteItems(noteId: Int) throws
    func deleteNoteItem(noteId: Int, noteItemId: Int) throws
    func moveNoteItem(noteId: Int, noteItemId: Int, newNoteItemId: Int) throws
}

struct CoreDataHelper: CoreDataHelperProtocol {
    static let containerName = "CalNotes"
    static let shared = CoreDataHelper()
    var container: NSPersistentContainer = NSPersistentContainer(name: containerName)

    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }

    mutating func deleteAll() throws {
        // Get a reference to a NSPersistentStoreCoordinator
        let storeContainer = container.persistentStoreCoordinator

        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            try storeContainer.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
        }

        // Re-create the persistent container
        container = NSPersistentContainer(name: "CalNotes")

        // Calling loadPersistentStores will re-create the persistent stores
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func notes() throws -> [CDNote] {
        let request = CDNote.fetchRequest()
        request.predicate = NSPredicate(format: "disabled==false")
        return try container.viewContext
            .fetch(request)
            .sorted(by: {
                guard let date1 = DateUtil.shared.date(from: $0.lastUpdate),
                      let date2 = DateUtil.shared.date(from: $1.lastUpdate) else {
                    return false
                }
                return date1 > date2
            })  // new to old
    }

    func disabledNotes() throws -> [CDNote] {
        let request = CDNote.fetchRequest()
        request.predicate = NSPredicate(format: "disabled==true")
        return try container.viewContext
            .fetch(request)
            .sorted(by: {
                guard let date1 = DateUtil.shared.date(from: $0.lastUpdate),
                      let date2 = DateUtil.shared.date(from: $1.lastUpdate) else {
                    return false
                }
                return date1 > date2
            })  // new to old
    }

    func note(noteId: Int) throws -> CDNote {
        let request = CDNote.fetchRequest()
        request.predicate = NSPredicate(format: "id==\(noteId)")
        guard let note = try container.viewContext.fetch(request).first else {
            fatalError("note not found for noteId=\(noteId)")
        }
        return note
    }

    func nextNoteId() throws -> Int16 {
        let lastId = try container.viewContext
            .fetch(CDNote.fetchRequest())
            .sorted(by: { $0.id < $1.id })
            .last?.id ?? -1
        return lastId + 1
    }

    func newNote(form: CreateNoteForm) throws -> CDNote {
        let nextNoteId = try nextNoteId()
        let note = CDNote(context: container.viewContext)
        note.id = nextNoteId
        note.title = form.title
        note.lastUpdate = DateUtil.shared.string(from: Date())
        return note
    }

    func createNote(form: CreateNoteForm) throws -> CDNote {
        let note = try newNote(form: form)
        try container.viewContext.save()
        return note
    }

    func cloneNote(noteId: Int) throws -> CDNote {
        let origin = try note(noteId: noteId)
        let note = try createNote(form: CreateNoteForm(title: "note_copy_name_format".localized(with: [origin.title])))
        _ = try copyNoteItems(from: noteId, to: Int(note.id))
        return note
    }

    func editNoteTitle(noteId: Int, form: CreateNoteForm) throws {
        let note = try note(noteId: noteId)
        note.title = form.title
        try container.viewContext.save()
        try updateNoteLastUpdate(noteId: noteId)
    }

    func updateNoteLastUpdate(noteId: Int) throws {
        let note = try note(noteId: noteId)
        note.lastUpdate = DateUtil.shared.string(from: Date())
        try container.viewContext.save()
    }

    func deleteNote(noteId: Int) throws {
        let note = try note(noteId: noteId)
        if note.disabled {
            container.viewContext.delete(note)
            try deleteNoteItems(noteId: noteId)  // delete all related note items
        } else {
            note.disabled = true  // move to bin
        }
        try container.viewContext.save()
    }

    func deleteAllDisabledNotes() throws {
        let notes = try disabledNotes()
        for note in notes {
            container.viewContext.delete(note)
        }
        try container.viewContext.save()
    }

    func recoverNote(noteId: Int) throws {
        let note = try note(noteId: noteId)
        note.disabled = false
        try container.viewContext.save()
    }

    func noteItems() throws -> [CDNoteItem] {
        return try container.viewContext.fetch(CDNoteItem.fetchRequest()).sorted(by: { $0.id < $1.id })
    }

    func noteItems(noteId: Int) throws -> [CDNoteItem] {
        let request = CDNoteItem.fetchRequest()
        request.predicate = NSPredicate(format: "noteId==\(noteId)")
        return try container.viewContext.fetch(request).sorted(by: { $0.id < $1.id })
    }

    func noteItem(noteId: Int, noteItemId: Int) throws -> CDNoteItem {
        let request = CDNoteItem.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "id==\(noteItemId)"),
            NSPredicate(format: "noteId==\(noteId)")
        ])
        guard let noteItem = try container.viewContext.fetch(request).first else {
            fatalError("note item not found for noteId=\(noteId), noteItemId=\(noteItemId)")
        }
        return noteItem
    }

    func nextNoteItemId(noteId: Int) throws -> Int16 {
        let request = CDNoteItem.fetchRequest()
        request.predicate = NSPredicate(format: "noteId==\(noteId)")
        let lastId = try container.viewContext
            .fetch(request)
            .sorted(by: { $0.id < $1.id })
            .last?.id ?? -1
        return lastId + 1
    }

    func newNoteItem(noteId: Int, form: NoteItemForm) throws -> CDNoteItem {
        let noteItem = CDNoteItem(context: container.viewContext)
        noteItem.id = try nextNoteItemId(noteId: noteId)
        noteItem.noteId = Int16(noteId)
        noteItem.update(form: form)
        return noteItem
    }

    func createNoteItem(noteId: Int, form: NoteItemForm) throws -> CDNoteItem {
        let noteItem = try newNoteItem(noteId: noteId, form: form)
        try container.viewContext.save()
        try updateNoteLastUpdate(noteId: noteId)
        return noteItem
    }

    func cloneNoteItem(noteId: Int, noteItemId: Int) throws -> CDNoteItem {
        let origin = try noteItem(noteId: noteId, noteItemId: noteItemId)
        let noteItem = try createNoteItem(noteId: noteId, form: NoteItemForm(cdNoteItem: origin))
        try moveNoteItem(noteId: noteId, noteItemId: Int(noteItem.id), newNoteItemId: noteItemId+1)
        return noteItem
    }

    func updateNoteItem(noteId: Int, noteItemId: Int, form: NoteItemForm) throws -> CDNoteItem {
        let noteItem = try noteItem(noteId: noteId, noteItemId: noteItemId)
        noteItem.update(form: form)
        try container.viewContext.save()
        try updateNoteLastUpdate(noteId: noteId)
        return noteItem
    }

    func copyNoteItems(from oldNoteId: Int, to newNoteId: Int) throws -> [CDNoteItem] {
        let originNoteItems = try noteItems(noteId: oldNoteId)
        for noteItem in originNoteItems {
            _ = try newNoteItem(noteId: newNoteId, form: NoteItemForm(cdNoteItem: noteItem))
        }
        return try noteItems(noteId: newNoteId)
    }

    func deleteNoteItems(noteId: Int) throws {
        let noteItems = try noteItems(noteId: noteId)
        for item in noteItems {
            container.viewContext.delete(item)
        }
        try container.viewContext.save()
    }

    func deleteNoteItem(noteId: Int, noteItemId: Int) throws {
        let noteItem = try noteItem(noteId: noteId, noteItemId: noteItemId)
        container.viewContext.delete(noteItem)
        try container.viewContext.save()
        try updateNoteLastUpdate(noteId: noteId)
    }

    func moveNoteItem(noteId: Int, noteItemId: Int, newNoteItemId: Int) throws {
        if noteItemId == newNoteItemId {
            return
        }

        // get moved note item before set affected items
        let noteItem = try noteItem(noteId: noteId, noteItemId: noteItemId)
        // set new id to affected note items
        if noteItemId < newNoteItemId {
            let request = CDNoteItem.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "id>=\(noteItemId+1) && id<=\(newNoteItemId)"),
                NSPredicate(format: "noteId==\(noteId)")
            ])
            let noteItems = try container.viewContext.fetch(request)
            for noteItem in noteItems {
                noteItem.id -= 1
            }
        } else {let request = CDNoteItem.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "id>=\(newNoteItemId) && id<=\(noteItemId-1)"),
                NSPredicate(format: "noteId==\(noteId)")
            ])
            let noteItems = try container.viewContext.fetch(request)
            for noteItem in noteItems.reversed() {  // start from largest id
                noteItem.id += 1
            }
        }
        // save moved note item id
        noteItem.id = Int16(newNoteItemId)
        try container.viewContext.save()
        try updateNoteLastUpdate(noteId: noteId)
    }
}
