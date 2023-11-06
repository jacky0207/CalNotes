//
//  NoteCreateFormView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-03.
//

import SwiftUI

struct NoteCreateFormView: View {
    @Binding var isPresented: Bool
    var action: (CreateNoteForm) -> Void
    @State private var form: CreateNoteForm.LocalForm = .none

    init(
        isPresented: Binding<Bool>,
        title: String = "",
        action: @escaping (CreateNoteForm) -> Void
    ) {
        self._isPresented = isPresented
        self.action = action
        self._form = State(initialValue: CreateNoteForm.LocalForm(title: title))
    }

    var body: some View {
        AlertView(
            isPresented: $isPresented,
            title: "note_title_question".localized(),
            action: alertAction,
            actionDisabled: !form.isValid(),
            content: alertContent
        )
        .accessibilityIdentifier("createNoteForm")
    }

    func alertAction() {
        action(CreateNoteForm(localForm: form))
    }

    func alertContent() -> some View {
        FormTextField(
            title: "",
            text: $form.title
        )
        .accessibilityIdentifier("titleField")
    }
}

struct NoteCreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteCreateFormView(isPresented: .constant(true)) { _ in

            }
            NoteCreateFormView(isPresented: .constant(true), title: "Title") { _ in

            }
            .previewDisplayName("Default Title")
        }
    }
}
