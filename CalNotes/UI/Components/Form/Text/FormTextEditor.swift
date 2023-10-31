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
    @Binding var errorMessage: String
    var keyboardType: UIKeyboardType
    var maxLength: Int?

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        errorMessage: Binding<String> = .constant(""),
        keyboardType: UIKeyboardType = .default,
        maxLength: Int? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._errorMessage = errorMessage
        self.keyboardType = keyboardType
        self.maxLength = maxLength
    }

    var body: some View {
        FormView(
            title: title,
            errorMessage: $errorMessage,
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
        .stackStyle(StackStyle.RoundedRect(isError: !errorMessage.isEmpty))
    }

    func textEditor() -> some View {
        TextEditor(text: $text)
            .frame(height: Dimen.float(.textEditorHeight))
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
                text: .constant("")
            )
            .previewLayout(.sizeThatFits)

            FormTextEditor(
                title: "Remark",
                placeholder: "Comment",
                text: .constant(""),
                errorMessage: .constant("Please enter")
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Error")
        }
    }
}
