//
//  FormTextEditor.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct FormTextEditor: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var message: String
    var messageType: FormMessageType
    var keyboardType: UIKeyboardType
    var maxLength: Int?

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        message: Binding<String> = .constant(""),
        messageType: FormMessageType = .info,
        keyboardType: UIKeyboardType = .default,
        maxLength: Int? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._message = message
        self.messageType = messageType
        self.keyboardType = keyboardType
        self.maxLength = maxLength
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
        ZStack {
            textEditor()
            if text.isEmpty {
                textEditorPlaceholder()
            }
        }
    }

    func textEditor() -> some View {
        TextEditor(text: $text)
            .textEditorStyle(TextEditorStyle.RoundedRect(isError: messageType == .error && !message.isEmpty))
            .keyboardType(keyboardType)
            .onChange(of: text) { _ in
                if let maxLength = maxLength, text.count > maxLength {
                    text = String(text.prefix(maxLength))
                }
            }
    }

    func textEditorPlaceholder() -> some View {
        Text(placeholder)
            .frame(maxWidth: .infinity, maxHeight: Dimen.float(.textEditorHeight), alignment: .topLeading)
            .padding(EdgeInsets(top: Dimen.spacing(.small), leading: Dimen.spacing(.normal), bottom: Dimen.spacing(.small), trailing: Dimen.spacing(.normal)))
            .textStyle(TextStyle.FormPlaceholder())
    }
}

struct FormTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormTextEditor(
                title: "Remark",
                placeholder: "Comment",
                text: .constant(""),
                message: .constant("Our company will look for it")
            )
            .previewLayout(.sizeThatFits)

            FormTextEditor(
                title: "Remark",
                placeholder: "Comment",
                text: .constant(""),
                message: .constant("Please enter"),
                messageType: .error
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Error")
        }
    }
}
