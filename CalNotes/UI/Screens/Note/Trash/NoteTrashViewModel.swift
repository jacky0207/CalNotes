//
//  NoteTrashViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-28.
//

import SwiftUI

class NoteTrashViewModel: ViewModel, ObservableObject, NoteTrashProtocol {
    @Published var list: NoteList = .none
    @Published var selectedNoteId: Int = -1

    override func loadData() {
        super.loadData()
        getAllNotes()
    }

    func getAllNotes() {
        dataService.getAllDisabledNotes()
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

    func deleteAllDisabledNotes(completion: @escaping () -> Void) {
        dataService.deleteAllDisabledNote()
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

    func recoverNote(noteId: Int) {
        dataService.recoverNote(noteId: noteId)
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

    func recoverNote(at index: Int) {
        recoverNote(noteId: list.notes[index].id)
    }
}

#if DEBUG
extension NoteTrashViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer())
        if preview {
            list = ModelData().noteList
        }
    }
}
#endif
