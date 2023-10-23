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
        PickerMenu(
            selectedId: $selectedId,
            data: data,
            rightView: { Image("arrow_down").allowsTightening(false) }
        )
        .textStyle(TextStyle.Regular())
        .stackStyle(StackStyle.RoundedRect())
        .onChange(of: selectedId) { _ in
            message = ""
            onSelectedChanged(selectedId)
        }
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
