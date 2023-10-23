//
//  FormPicker.swift
//  FormEngineSwiftUI
//
//  Created by Jacky Lam on 2023-04-23.
//

import SwiftUI

struct FormPicker: View {
    var title: String
    @Binding var selectedId: Int
    var data: [PickerItem]
    @Binding var message: String
    var messageType: FormMessageType
    var onSelectedChanged: (Int) -> Void

    init(
        title: String = "",
        selectedId: Binding<Int>,
        data: [PickerItem],
        message: Binding<String> = .constant(""),
        messageType: FormMessageType = .error,
        onSelectedChanged: @escaping (Int) -> Void = { _ in }
    ) {
        self.title = title
        self._selectedId = selectedId
        self.data = data
        self._message = message
        self.messageType = messageType
        self.onSelectedChanged = onSelectedChanged
    }

    init(
        title: String = "",
        field: Binding<FormField<Int>>,
        data: [PickerItem],
        onSelectedChanged: @escaping (Int) -> Void = { _ in }
    ) {
        self.init(
            title: title,
            selectedId: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            data: data,
            message: Binding(
                get: { field.wrappedValue.message },
                set: { field.wrappedValue.message = $0 }
            ),
            messageType: field.wrappedValue.messageType,
            onSelectedChanged: onSelectedChanged
        )
    }

    var body: some View {
        FormView(
            title: title,
            message: $message,
            messageType: messageType,
            content: content
        )
    }

    func content() -> some View {
        FormPickerMenu(
            selectedId: $selectedId,
            data: data
        )
        .onChange(of: selectedId) { _ in
            message = ""
            onSelectedChanged(selectedId)
        }
    }
}

struct FormPickerMenu: View {
    @Binding var selectedId: Int
    var data: [PickerItem]

    var body: some View {
        Menu(
            content: content,
            label: label
        )
    }

    func content() -> some View {
        Picker("", selection: $selectedId) {
            pickerDefaultItem()
            ForEach(data, id: \.id) { element in
                pickerItem(content: element.value)
            }
        }
    }

    func pickerDefaultItem() -> some View {
        Text(" ").tag(-1)
    }

    func pickerItem(content: String) -> some View {
        Text(content)
    }

    func label() -> some View {
        HStack(spacing: Dimen.spacing(.xSmall)) {
            labelTitle()
            labelIcon()
        }
        .stackStyle(StackStyle.RoundedRect())
    }

    func labelTitle() -> some View {
        Text(data.first(where: { $0.id == selectedId })?.value ?? " ")
            .textStyle(TextStyle.Regular())
    }

    func labelIcon() -> some View {
        VStack {
            Image("arrow_down")
                .resizable()
                .imageStyle(ImageStyle.Icon())
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct FormPicker_Previews: PreviewProvider {
    static var previews: some View {
        FormPicker(
            title: "Color",
            selectedId: .constant(2),
            data: [
                PickerItem(id: 0, value: "Red"),
                PickerItem(id: 1, value: "Green"),
                PickerItem(id: 2, value: "Blue"),
            ],
            message: .constant("")
        )
        .previewLayout(.sizeThatFits)
    }
}
