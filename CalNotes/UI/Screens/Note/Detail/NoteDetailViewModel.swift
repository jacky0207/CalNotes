//
//  NoteDetailViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI
import Combine

class NoteDetailViewModel: ViewModel, ObservableObject, NoteDetailProtocol {
    var id: Int
    @Published var note: NoteDetail = .none

    required init(diContainer: DIContainer, id: Int) {
        self.id = id
        super.init(diContainer: diContainer)
    }

    override func loadData() {
        super.loadData()
        getNoteDetail()
    }

    func getNoteDetail() {
        dataService.getNoteDetail(noteId: id)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { note in
                    self.note = note
                }
            )
            .store(in: &cancellables)
    }

    func editNoteTitle(form: CreateNoteForm) {
        dataService.editNoteTitle(noteId: id, form: form)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { note in
                    self.note = note  // refresh ui
                }
            )
            .store(in: &cancellables)
    }

    func deleteNote(completion: @escaping () -> Void) {
        dataService.deleteNote(noteId: id)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { _ in
                    completion()
                }
            )
            .store(in: &cancellables)
    }

    func deleteNoteItem(noteItemId: Int) {
        dataService.deleteNoteItem(noteId: id, noteItemId: noteItemId)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteDetail in
                    self.note = noteDetail
                }
            )
            .store(in: &cancellables)
    }

    func deleteNoteItem(at index: Int) {
        deleteNoteItem(noteItemId: note.items[index].id)
    }

    func moveNoteItem(noteItemId: Int, newNoteItemId: Int) {
        dataService.moveNoteItem(noteId: self.id, noteItemId: noteItemId, newNoteItemId: newNoteItemId)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteDetail in
                    self.note = noteDetail
                }
            )
            .store(in: &self.cancellables)
    }

    func moveNoteItem(from source: IndexSet, to destination: Int) {
        let oldIndex = source.first!
        let newIndex = destination < oldIndex ? destination : destination-1  // destination value include self
        moveNoteItem(
            noteItemId: note.items[oldIndex].id,
            newNoteItemId: note.items[newIndex].id
        )
    }

    func cloneNoteItem(noteItemId: Int) {
        dataService.cloneNoteItem(noteId: id, noteItemId: noteItemId)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { note in
                    self.note = note
                }
            )
            .store(in: &cancellables)
    }

    func cloneNoteItem(at index: Int) {
        cloneNoteItem(noteItemId: note.items[index].id)
    }
}

#if DEBUG
extension NoteDetailViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer(), id: 0)
        if preview {
            note = ModelData().noteDetail
        }
    }
}
#endif
