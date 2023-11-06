//
//  NoteListView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

struct NoteListView: View {
    @Environment(\.diContainer) var diContainer
    @ObservedObject var viewModel: NoteListViewModel
    @State private var isShowCreateForm = false
    @State private var isNoteSelected = false

    var body: some View {
        BodyView(
            title: "notes",
            titleDisplayType: .large,
            toolbar: toolbarTrailing,
            content: content
        )
        .safeAreaInset(edge: .bottom) {
            BannerView()
                .frame(height: 60)
                .background(ColorStyle.background.color)
        }
        .accessibilityIdentifier("noteList")
        .onAppear(perform: viewModel.loadData)
        .overlay(content: createFormContent)
    }

    func toolbarTrailing() -> some View {
        NoteListTrailingToolbar(
            noteId: { viewModel.selectedNoteId },
            isShowCreateForm: $isShowCreateForm,
            isNoteSelected: $isNoteSelected
        )
    }

    func content() -> some View {
        DataList(
            data: viewModel.list.notes,
            spacing: Dimen.spacing(.verticalRow),
            padding: EdgeInsets(
                top: Dimen.spacing(.topMargin),
                leading: Dimen.spacing(.horizontalMargin),
                bottom: Dimen.spacing(.bottomMargin),
                trailing: Dimen.spacing(.horizontalMargin)
            ),
            content: { NoteListItemView(note: $0) },
            swipeContent: cloneButton,
            deleteItem: {
                viewModel.deleteNote(at: $0.first!)
            }
        )
        .accessibilityIdentifier("noteList")
    }

    func createFormContent() -> some View {
        isShowCreateForm ? AnyView(createFormView()) : AnyView(EmptyView())
    }

    func createFormView() -> some View {
        NoteCreateFormView(isPresented: $isShowCreateForm) { form in
            createNote(form: form)
        }
    }

    func createNote(form: CreateNoteForm) -> Void {
        viewModel.createNote(form: form) { note in
            isNoteSelected = true
        }
    }

    func cloneButton(_ indexSet: IndexSet) -> some View {
        Button(action: { cloneNote(at: indexSet) }) {
            Image("clone")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .imageStyle(ImageStyle.Icon())
        }
        .tint(.blue)
        .accessibilityIdentifier("listRowCloneButton")
    }

    func cloneNote(at indexSet: IndexSet) {
        viewModel.cloneNote(at: indexSet.first!) { note in
            isNoteSelected = true
        }
    }
}

struct NoteListTrailingToolbar: View {
    @Environment(\.diContainer) var diContainer
    var noteId: () -> Int
    @Binding var isShowCreateForm: Bool
    @Binding var isNoteSelected: Bool

    var body: some View {
        Button(
            action: { isShowCreateForm.toggle() },
            label: label
        )
        .accessibilityIdentifier("createNoteButton")
        .navigationLinkBackground(
            destination: destination,
            isActive: $isNoteSelected
        )
    }

    func destination() -> some View {
        NoteDetailView(viewModel: NoteDetailViewModel(
            diContainer: diContainer,
            id: noteId()
        ))
    }

    func label() -> some View {
        Image("writing")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}

struct NoteListItemView: View {
    @Environment(\.diContainer) var diContainer
    var note: Note

    var body: some View {
        NavigationViewLink(
            destination: destination,
            label: label
        )
    }

    func destination() -> NoteDetailView {
        NoteDetailView(viewModel: NoteDetailViewModel(
            diContainer: diContainer,
            id: note.id
        ))
    }

    func label() -> some View {
        NoteView(note: note)
    }
}

#if DEBUG
struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoteListView(viewModel: NoteListViewModel(preview: true))
                    .environment(\.defaultMinListRowHeight, 0)
            }

            NavigationView {
                NoteListView(viewModel: NoteListViewModel(preview: false))
                    .environment(\.defaultMinListRowHeight, 0)
            }
            .previewDisplayName("No Item")
        }
    }
}
#endif
