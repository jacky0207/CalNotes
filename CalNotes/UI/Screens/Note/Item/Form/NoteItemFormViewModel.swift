//
//  NoteItemFormViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import Combine
import SwiftUI

class NoteItemFormViewModel: ViewModel, ObservableObject, NoteItemFormProtocol {
    var noteId: Int
    var noteItemId: Int?
    @Published var form: NoteItemForm.LocalForm = .none

    required init(diContainer: DIContainer, noteId: Int, noteItemId: Int?, image: UIImage?) {
        self.noteId = noteId
        self.noteItemId = noteItemId
        self.form = .image(image)
        super.init(diContainer: diContainer)
    }

    override func loadData() {
        super.loadData()
        getNoteItemDetail()
    }

    func getNoteItemDetail() {
        guard let noteItemId = noteItemId else {
            return
        }
        dataService.getNoteItemDetail(noteId: noteId, noteItemId: noteItemId)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteItemDetail in
                    self.form = NoteItemForm.LocalForm(noteItemDetail: noteItemDetail)
                }
            )
            .store(in: &cancellables)
    }

    func addNoteItem(completion: @escaping (NoteItemDetail) -> Void) {
        if !form.isValid() {
            form.validate()
            return
        }
        dataService.addNoteItem(noteId: noteId, form: NoteItemForm(localForm: form))
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteItemDetail in
                    completion(noteItemDetail)
                }
            )
            .store(in: &cancellables)
    }

    func updateNoteItem(completion: @escaping (NoteItemDetail) -> Void) {
        guard let noteItemId = noteItemId else {
            return
        }
        if !form.isValid() {
            form.validate()
            return
        }
        dataService.updateNoteItem(noteId: noteId, noteItemId: noteItemId, form: NoteItemForm(localForm: form))
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { noteItemDetail in
                    completion(noteItemDetail)
                }
            )
            .store(in: &cancellables)
    }
}

#if DEBUG
extension NoteItemFormViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer(), noteId: 0, noteItemId: 0, image: nil)
        if preview {
            form = NoteItemForm.LocalForm(noteItemDetail: ModelData().noteItemDetail)
        }
    }
}
#endif
