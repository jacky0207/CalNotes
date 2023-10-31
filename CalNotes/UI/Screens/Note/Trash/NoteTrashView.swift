//
//  NoteTrashView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-28.
//

import SwiftUI

struct NoteTrashView: View {
    @Environment(\.diContainer) var diContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: NoteTrashViewModel
    @State private var isShowDeleteAllNotes = false

    var body: some View {
        BodyView(
            title: "note_trash",
            titleDisplayType: .large,
            toolbar: toolbar,
            content: content
        )
        .onAppear(perform: viewModel.loadData)
        .overlay(content: confirmDeleteAllNotesContent)
    }

    func toolbar() -> some View {
        NoteTrashToolbar(
            isShowDeleteAllNotes: $isShowDeleteAllNotes
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
            swipeContent: recoverButton,
            deleteItem: {
                viewModel.deleteNote(at: $0.first!)
            }
        )
    }

    func confirmDeleteAllNotesContent() -> some View {
        if !isShowDeleteAllNotes {
            return AnyView(EmptyView())
        }
        return AnyView(AlertView(
            isPresented: $isShowDeleteAllNotes,
            title: "delete_note_confirm_question".localized(),
            message: "delete_note_confirm_message".localized(),
            action: {
                viewModel.deleteAllDisabledNotes {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        ))
    }

    func recoverButton(at indexSet: IndexSet) -> some View {
        Button(action: { recoverNote(at: indexSet) }) {
            Image("recover")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .imageStyle(ImageStyle.Icon())
        }
        .tint(.green)
    }

    func recoverNote(at indexSet: IndexSet) {
        viewModel.recoverNote(at: indexSet.first!)
    }
}

struct NoteTrashToolbar: View {
    @Environment(\.diContainer) var diContainer
    @Binding var isShowDeleteAllNotes: Bool

    var body: some View {
        deleteButton()
    }

    func deleteButton() -> some View {
        Button(
            action: {
                isShowDeleteAllNotes.toggle()
            },
            label: {
                Image("trash")
                    .resizable()
                    .imageStyle(ImageStyle.Icon())
            }
        )
    }
}

#if DEBUG
struct NoteTrashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoteTrashView(viewModel: NoteTrashViewModel(preview: true))
                    .environment(\.defaultMinListRowHeight, 0)
            }
            .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad

            NavigationView {
                NoteTrashView(viewModel: NoteTrashViewModel(preview: false))
                    .environment(\.defaultMinListRowHeight, 0)
            }
            .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad
            .previewDisplayName("No Item")
        }
    }
}
#endif
