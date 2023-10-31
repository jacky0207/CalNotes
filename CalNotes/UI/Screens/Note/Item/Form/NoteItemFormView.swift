//
//  NoteItemFormView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

struct NoteItemFormView: View {
    @ObservedObject var viewModel: NoteItemFormViewModel
    @State private var isShowAmountCalculator = false

    var body: some View {
        BodyView(
            title: viewModel.noteItemId == nil ? "add_note_item" : "update_note_item",
            toolbar: toolbar,
            content: content
        )
        .onAppear(perform: viewModel.loadData)
        .bottomSheet(
            isPresented: $isShowAmountCalculator,
            backgroundColor: CalculatorColor.black,
            detents: [.medium()],
            content: {
                CalculatorView(sum: viewModel.form.amount.value) { sum in
                    viewModel.form.amount.value = sum
                }
            }
        )
    }

    func toolbar() -> some View {
        NoteItemFormToolbar(
            sendAction: viewModel.noteItemId == nil ? viewModel.addNoteItem : viewModel.updateNoteItem,
//            sendDisabled: !viewModel.form.isValid()
            sendDisabled: false
        )
    }

    func content() -> some View {
        FormSheet(
            padding: EdgeInsets(
                top: Dimen.spacing(.topMargin),
                leading: Dimen.spacing(.horizontalMargin),
                bottom: Dimen.spacing(.bottomMargin),
                trailing: Dimen.spacing(.horizontalMargin)
            ),
            content: formContent
        )
    }

    func formContent() -> some View {
        Group {
            FormPicker(
                title: "category".localized(),
                field: $viewModel.form.category,
                data: NoteItemCategory.items,
                leftView: categoryIcon,
                onSelectedChanged: { id in
                    if viewModel.form.title.value.isEmpty {
                        viewModel.form.title.value = NoteItemCategory(rawValue: id)?.name ?? ""
                    }
                }
            )
            FormTextField(
                title: "title".localized(),
                field: $viewModel.form.title,
                rightView: removeTitleButton
            )
            FormTextField(
                title: "amount".localized(),
                field: $viewModel.form.amount,
                keyboardType: .decimalPad,
                leftView: { Text("dollar_sign") },
                rightView: amountCalculatorButton
            )
            FormImagePicker(
                title: "image".localized(),
                field: $viewModel.form.image
            )
            FormTextEditor(
                title: "remarks".localized(),
                text: $viewModel.form.remarks.value
            )
        }
    }

    func categoryIcon() -> some View {
        if let category = NoteItemCategory(rawValue: viewModel.form.category.value) {
            return AnyView(category.icon.resizable().imageStyle(ImageStyle.Icon()))
        } else {
            return AnyView(EmptyView())
        }
    }

    func removeTitleButton() -> some View {
        if viewModel.form.title.value == "" {
            return AnyView(EmptyView())
        } else {
            return AnyView(Button(action: { viewModel.form.title.value = "" }) {
                Image("remove").resizable().imageStyle(ImageStyle.Icon())
            })
        }
    }

    func amountCalculatorButton() -> some View {
        Button(
            action: { isShowAmountCalculator.toggle() },
            label: { Image("calculator").resizable().imageStyle(ImageStyle.Icon()) }
        )
    }
}

struct NoteItemFormToolbar: View {
    @Environment(\.dismiss) var dismiss
    var sendAction: (@escaping (NoteItemDetail) -> Void) -> Void
    var sendDisabled: Bool

    var body: some View {
        Button(
            action: action,
            label: label
        )
        .disabled(sendDisabled)
    }

    func action() {
        sendAction { _ in
            dismiss()
        }
    }

    func label() -> some View {
        Image("send")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}

struct NoteItemFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoteItemFormView(viewModel: NoteItemFormViewModel(diContainer: DIContainer(), noteId: 0, noteItemId: nil))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDisplayName("Add Form")
            
            NavigationView {
                NoteItemFormView(viewModel: NoteItemFormViewModel(preview: true))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDisplayName("Update Form")
        }
    }
}
