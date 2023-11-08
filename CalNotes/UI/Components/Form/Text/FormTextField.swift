//
//  FormTextField.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormTextField<LeftView: View, RightView: View>: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var errorMessage: String
    var keyboardType: UIKeyboardType
    var min: Float?
    var max: Float?
    var leftView: () -> LeftView
    var rightView: () -> RightView
    var spacing: CGFloat

    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        errorMessage: Binding<String> = .constant(""),
        keyboardType: UIKeyboardType = .default,
        min: Float? = nil,
        max: Float? = nil,
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { EmptyView() },
        spacing: CGFloat = Dimen.spacing(.small)
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._errorMessage = errorMessage
        self.keyboardType = keyboardType
        self.min = min
        self.max = max
        self.leftView = leftView
        self.rightView = rightView
        self.spacing = spacing
    }

    init(
        title: String = "",
        placeholder: String = "",
        field: Binding<FormField<String>>,
        keyboardType: UIKeyboardType = .default,
        min: Float? = nil,
        max: Float? = nil,
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { EmptyView() },
        spacing: CGFloat = Dimen.spacing(.small)
    ) {
        self.init(
            title: title,
            placeholder: placeholder,
            text: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            errorMessage: Binding(
                get: { field.wrappedValue.errorMessage },
                set: { field.wrappedValue.errorMessage = $0 }
            ),
            keyboardType: keyboardType,
            min: min,
            max: max,
            leftView: leftView,
            rightView: rightView,
            spacing: spacing
        )
    }

    var body: some View {
        FormView(
            title: title,
            errorMessage: $errorMessage,
            content: content
        )
    }

    func content() -> some View {
        LeftRightViewHStack(
            content: {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .accessibilityIdentifier("content")
            },
            leftView: { FormView<LeftView>.styled(leftView()) },
            rightView: { FormView<LeftView>.styled(rightView()) },
            spacing: spacing
        )
        .stackStyle(StackStyle.RoundedRect(isError: !errorMessage.isEmpty))
        .onChange(of: text) { _ in
            switch keyboardType {
            case .numberPad, .decimalPad:
                guard let number = Float(text) else {
                    errorMessage = ""
                    return
                }
                if let min = min, number < min {
                    self.text = "\(min)"
                } else if let max = max, number > max {
                    self.text = "\(max)"
                }
            default:
                break
            }
            errorMessage = ""
        }
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormTextField(
                title: "Last Name",
                placeholder: "e.g. Tai Man",
                text: .constant(""),
                errorMessage: .constant("Please enter \"Tai Man\" for \"Chan Tai Man\""),
                leftView: { Text("HKD") },
                rightView: { Button(action: {}) { Image("remove") } }
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
