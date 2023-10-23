//
//  FormTextField.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormTextField<LeftView: View>: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var message: String
    var messageType: FormMessageType
    var keyboardType: UIKeyboardType
    var leftView: () -> LeftView

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        message: Binding<String> = .constant(""),
        messageType: FormMessageType = .info,
        keyboardType: UIKeyboardType = .default,
        leftView: @escaping () -> LeftView = { EmptyView() }
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._message = message
        self.messageType = messageType
        self.keyboardType = keyboardType
        self.leftView = leftView
    }

    init(
        title: String = "",
        placeholder: String = "",
        field: Binding<FormField<String>>,
        keyboardType: UIKeyboardType = .default,
        leftView: @escaping () -> LeftView = { EmptyView() }
    ) {
        self.init(
            title: title,
            placeholder: placeholder,
            text: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            message: Binding(
                get: { field.wrappedValue.message },
                set: { field.wrappedValue.message = $0 }
            ),
            messageType: field.wrappedValue.messageType,
            keyboardType: keyboardType,
            leftView: leftView
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
        HStack(spacing: Dimen.spacing(.xSmall)) {
            leftView()
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .onChange(of: text) { _ in
                    message = ""
                }
        }
        .textStyle(TextStyle.Regular())
        .stackStyle(StackStyle.RoundedRect())
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        FormTextField(
            title: "Last Name",
            placeholder: "e.g. Tai Man",
            text: .constant(""),
            message: .constant("Please enter \"Tai Man\" for \"Chan Tai Man\""),
            leftView: { Text("HKD") }
        )
        .previewLayout(.sizeThatFits)
    }
}
