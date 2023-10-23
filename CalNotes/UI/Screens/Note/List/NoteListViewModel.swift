//
//  NoteListViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Foundation
import Combine

class NoteListViewModel: ViewModel, ObservableObject, NoteListProtocol {
    @Published var list: NoteList = .none
    @Published var selectedNoteId: Int = -1

    override func loadData() {
        super.loadData()
        getAllNotes()
    }

    func getAllNotes() {
        dataService.getAllNotes()
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteList in
                    self.list = noteList
                }
            )
            .store(in: &cancellables)
    }

    func createNote(form: CreateNoteForm, completion: @escaping (NoteDetail) -> Void) {
        dataService.createNote(form: form)
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
                    self.getAllNotes()  // refresh ui
                    self.selectedNoteId = note.id
                    completion(note)
                }
            )
            .store(in: &cancellables)
    }

    func deleteNote(noteId: Int) {
        dataService.deleteNote(noteId: noteId)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteList in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {  // ui freeze when List.onmove() is still executing
                        self.list = noteList
                    }
                }
            )
            .store(in: &cancellables)
    }

    func deleteNote(at index: Int) {
        deleteNote(noteId: list.notes[index].id)
    }

    func cloneNote(noteId: Int, completion: @escaping (NoteDetail) -> Void) {
        dataService.cloneNote(noteId: noteId)
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
                    self.getAllNotes()  // refresh ui
                    self.selectedNoteId = note.id
                    completion(note)
                }
            )
            .store(in: &cancellables)
    }

    func cloneNote(at index: Int, completion: @escaping (NoteDetail) -> Void) {
        cloneNote(noteId: list.notes[index].id, completion: completion)
    }
}

#if DEBUG
extension NoteListViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer())
        if preview {
            list = ModelData().noteList
        }
    }
}
#endif
