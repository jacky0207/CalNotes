//
//  NoteDetailView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.diContainer) var diContainer
    @ObservedObject var viewModel: NoteDetailViewModel
    @State private var isShowEditNoteTitle = false

    var body: some View {
        BodyView(
            title: viewModel.note.title,
            toolbar: toolbar,
            content: content
        )
        .onAppear(perform: viewModel.loadData)
        .overlay(content: editNoteTitleContent)
    }

    func toolbar() -> some View {
        NoteDetailToolbar(
            note: viewModel.note,
            isShowEditNoteTitle: $isShowEditNoteTitle,
            deleteNoteAction: deleteNote
        )
    }

    func content() -> some View {
        VStack(spacing: 0) {
            DataList(
                data: viewModel.note.items,
                content: listContent,
                swipeContent: cloneButton,
                deleteItem: {
                    viewModel.deleteNoteItem(at: $0.first!)
                },
                moveItem: { source, destination in
                    viewModel.moveNoteItem(from: source, to: destination)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            NoteDetailSumView(sum: viewModel.note.sum)
        }
    }

    func listContent(item: NoteItem) -> some View {
        NoteDetailItemView(item: item)
    }

    func editNoteTitleContent() -> some View {
        isShowEditNoteTitle ? AnyView(editNoteTitleView()) : AnyView(EmptyView())
    }

    func editNoteTitleView() -> some View {
        NoteCreateFormView(
            isPresented: $isShowEditNoteTitle,
            title: viewModel.note.title,
            action: editNoteTitle
        )
    }

    func editNoteTitle(form: CreateNoteForm) -> Void {
        viewModel.editNoteTitle(form: form)
    }

    func deleteNote() {
        viewModel.deleteNote {
            presentationMode.wrappedValue.dismiss()
        }
    }

    func cloneButton(_ indexSet: IndexSet) -> some View {
        Button(action: { cloneNoteItem(at: indexSet) }) {
            Image("clone")
                .renderingMode(.template)
                .foregroundColor(.white)
        }
        .tint(.blue)
    }

    func cloneNoteItem(at indexSet: IndexSet) {
        viewModel.cloneNoteItem(at: indexSet.first!)
    }
}

struct NoteDetailToolbar: View {
    @Environment(\.diContainer) var diContainer
    var note: NoteDetail
    @Binding var isShowEditNoteTitle: Bool
    var deleteNoteAction: () -> Void

    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            addButton()
            menu()
        }
    }

    func addButton() -> some View {
        NavigationViewLink(
            destination: addDestination,
            label: addLabel
        )
    }

    func addDestination() -> some View {
        NoteItemFormView(viewModel: NoteItemFormViewModel(
            diContainer: diContainer,
            noteId: note.id,
            noteItemId: nil
        ))
    }

    func addLabel() -> some View {
        Image("plus")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }

    func menu() -> some View {
        Menu(
            content: {
                editNoteTitleButton()
                deleteNoteButton()
            },
            label: menuLabel
        )
    }

    func menuLabel() -> some View {
        Image("menu")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }

    func editNoteTitleButton() -> some View {
        Button(
            action: { isShowEditNoteTitle = true },
            label: editNoteTitleLabel
        )
    }

    func editNoteTitleLabel() -> some View {
        HStack {
            Text("edit_note_name")
                .textStyle(TextStyle.Regular())
            Image("edit")
                .imageStyle(ImageStyle.Icon())
        }
    }

    func deleteNoteButton() -> some View {
        Button(
            role: .destructive,
            action: deleteNoteAction,
            label: deleteNoteLabel
        )
    }

    func deleteNoteLabel() -> some View {
        HStack {
            Text("delete_note")
                .textStyle(TextStyle.Regular())
            Image("trash")
                .renderingMode(.template)
                .foregroundColor(.red)
        }
    }
}

struct NoteDetailItemView: View {
    @Environment(\.diContainer) var diContainer
    var item: NoteItem

    var body: some View {
        NavigationViewLink(
            destination: destination,
            label: label
        )
    }

    func destination() -> some View {
        NoteItemFormView(viewModel: NoteItemFormViewModel(
            diContainer: diContainer,
            noteId: item.noteId,
            noteItemId: item.id
        ))
    }

    func label() -> some View {
        NoteItemView(item: item)
    }
}

struct NoteDetailSumView: View {
    var sum: Float

    var body: some View {
        HStack(spacing: Dimen.spacing(.small)) {
            sumTitle()
            Spacer()
            sumValue()
        }
        .padding(.all, Dimen.spacing(.large))
        .background(ColorStyle.sectionBackground.color)
    }

    func sumTitle() -> some View {
        Text(String(format: "sum".localized(), sum))
            .textStyle(TextStyle.SectionTitle   ())
    }

    func sumValue() -> some View {
        HStack(spacing: Dimen.spacing(.xSmall)) {
            Image("coin")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(ColorStyle.textSecondary.color)
                .imageStyle(ImageStyle.Icon())
            Text(String(format: "%.2f", sum))
                .textStyle(TextStyle.SectionTitle())
        }
    }
}

#if DEBUG
struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoteDetailView(viewModel: NoteDetailViewModel(preview: true))
            }
            .navigationViewStyle(NavigationViewStyle.Default())

            NavigationView {
                NoteDetailView(viewModel: NoteDetailViewModel(preview: false))
            }
            .navigationViewStyle(NavigationViewStyle.Default())
            .previewDisplayName("No Item")
        }
    }
}
#endif
