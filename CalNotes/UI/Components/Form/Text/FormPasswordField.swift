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
    @Binding var errorMessage: String

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        errorMessage: Binding<String> = .constant("")
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._errorMessage = errorMessage
    }

    var body: some View {
        FormView(
            title: title,
            errorMessage: $errorMessage,
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
