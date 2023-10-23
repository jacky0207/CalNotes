//
//  FormPasswordField.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormPasswordField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var message: String
    var messageType: FormMessageType

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        message: Binding<String> = .constant(""),
        messageType: FormMessageType = .info
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._message = message
        self.messageType = messageType
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
        SecureField(placeholder, text: $text)
            .textFieldStyle(RoundedRectTextFieldStyle())
    }
}

struct FormPasswordField_Previews: PreviewProvider {
    static var previews: some View {
        FormPasswordField(
            title: "Password",
            text: .constant("")
        )
        .previewLayout(.sizeThatFits)
    }
}
