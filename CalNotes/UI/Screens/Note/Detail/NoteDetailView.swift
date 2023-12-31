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
    @State private var isShowNoteItemCamera = false
    @State private var selectedImage: UIImage?
    @State private var isNoteItemPhotoTook = false

    var body: some View {
        BodyView(
            title: viewModel.note.title,
            toolbar: toolbar,
            content: content
        )
        .accessibilityIdentifier("noteDetail")
        .onAppear(perform: viewModel.loadData)
        .overlay(content: editNoteTitleContent)
        .sheet(isPresented: $isShowNoteItemCamera) {
            ImagePickerView(
                sourceType: .camera,
                selectedImage: $selectedImage,
                onSelectedChange: { _ in
                    isNoteItemPhotoTook.toggle()
                }
            )
        }
        .analyticsScreen(self)
    }

    func toolbar() -> some View {
        NoteDetailToolbar(
            note: viewModel.note,
            disabled: viewModel.note.disabled,
            isShowEditNoteTitle: $isShowEditNoteTitle,
            isShowNoteItemCamera: $isShowNoteItemCamera,
            isNoteItemPhotoTook: $isNoteItemPhotoTook,
            image: selectedImage,
            deleteNoteAction: deleteNote
        )
    }

    func content() -> some View {
        VStack(spacing: 0) {
            DataList(
                data: viewModel.note.items,
                content: listContent,
                swipeContent: viewModel.note.disabled ? nil : cloneButton,
                deleteItem: viewModel.note.disabled ? nil : {
                    viewModel.deleteNoteItem(at: $0.first!)
                },
                moveItem: viewModel.note.disabled ? nil : { source, destination in
                    viewModel.moveNoteItem(from: source, to: destination)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityIdentifier("noteItemList")
            NoteDetailSumView(sum: viewModel.note.sum)
        }
        .accessibilityElement(children: .contain)
    }

    func listContent(item: NoteItem) -> some View {
        NoteDetailItemView(item: item, disabled: viewModel.note.disabled)
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
        .accessibilityIdentifier("listRowCloneButton")
    }

    func cloneNoteItem(at indexSet: IndexSet) {
        viewModel.cloneNoteItem(at: indexSet.first!)
    }
}

struct NoteDetailToolbar: View {
    @Environment(\.diContainer) var diContainer
    var note: NoteDetail
    var disabled: Bool
    @Binding var isShowEditNoteTitle: Bool
    @Binding var isShowNoteItemCamera: Bool
    @Binding var isNoteItemPhotoTook: Bool
    var image: UIImage?
    var deleteNoteAction: () -> Void

    var body: some View {
        if disabled {
            EmptyView()
        } else {
            HStack(spacing: Dimen.spacing(.normal)) {
                addButton()
                menu()
            }
            .accessibilityElement(children: .contain)
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
            noteItemId: nil,
            image: nil
        ))
    }

    func addLabel() -> some View {
        Image("plus")
            .resizable()
            .imageStyle(ImageStyle.Icon())
            .accessibilityRemoveTraits(.isImage)
            .accessibilityAddTraits(.isButton)
            .accessibilityIdentifier("createNoteItemButton")
    }

    func menu() -> some View {
        Menu(
            content: {
                editNoteTitleButton()
                addNoteItemCameraButton()
                deleteNoteButton()
            },
            label: menuLabel
        )
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("noteDetailMenu")
        .navigationLinkBackground(
            destination: addPhotoDestination,
            isActive: $isNoteItemPhotoTook
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
        .accessibilityIdentifier("editNoteTitleButton")
    }

    func addPhotoDestination() -> some View {
        NoteItemFormView(viewModel: NoteItemFormViewModel(
            diContainer: diContainer,
            noteId: note.id,
            noteItemId: nil,
            image: image
        ))
    }

    func editNoteTitleLabel() -> some View {
        HStack {
            Text("edit_note_name")
                .textStyle(TextStyle.Regular())
            Image("edit")
                .imageStyle(ImageStyle.Icon())
        }
    }

    func addNoteItemCameraButton() -> some View {
        Button(
            action: { isShowNoteItemCamera = true },
            label: addNoteItemCameraLabel
        )
        .accessibilityIdentifier("addNoteItemCameraButton")
    }

    func addNoteItemCameraLabel() -> some View {
        HStack {
            Text("add_note_item_camera")
                .textStyle(TextStyle.Regular())
            Image("camera")
                .imageStyle(ImageStyle.Icon())
        }
    }

    func deleteNoteButton() -> some View {
        Button(
            role: .destructive,
            action: deleteNoteAction,
            label: deleteNoteLabel
        )
        .accessibilityIdentifier("deleteNoteButton")
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
    var disabled: Bool

    var body: some View {
        if disabled {
            label()
        } else {
            NavigationViewLink(
                destination: destination,
                label: label
            )
        }
    }

    func destination() -> some View {
        NoteItemFormView(viewModel: NoteItemFormViewModel(
            diContainer: diContainer,
            noteId: item.noteId,
            noteItemId: item.id,
            image: nil
        ))
    }

    func label() -> some View {
        NoteItemView(item: item, disabled: disabled)
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
        .stackStyle(StackStyle.SectionFooter())
    }

    func sumTitle() -> some View {
        Text(String(format: "sum".localized(), sum))
            .textStyle(TextStyle.SectionFooterTitle())
    }

    func sumValue() -> some View {
        HStack(spacing: Dimen.spacing(.xSmall)) {
            Text("dollar_format".localized(with: [sum]))
                .textStyle(TextStyle.SectionFooterTitle())
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
