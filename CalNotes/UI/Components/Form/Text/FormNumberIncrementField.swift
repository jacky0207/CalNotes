//
//  FormNumberIncrementField.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-28.
//

import SwiftUI

struct FormNumberIncrementField: View {
    var title: String
    @Binding var text: String
    var min: Float?
    var max: Float?
    @Binding var errorMessage: String

    init(
        title: String = "",
        text: Binding<String>,
        min: Float? = nil,
        max: Float? = nil,
        errorMessage: Binding<String> = .constant("")
    ) {
        self.title = title
        self._text = text
        self.min = min
        self.max = max
        self._errorMessage = errorMessage
    }

    init(
        title: String = "",
        placeholder: String = "",
        field: Binding<FormField<String>>,
        min: Float? = nil,
        max: Float? = nil
    ) {
        self.init(
            title: title,
            text: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            min: min,
            max: max,
            errorMessage: Binding(
                get: { field.wrappedValue.errorMessage },
                set: { field.wrappedValue.errorMessage = $0 }
            )
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
        HStack(spacing: Dimen.spacing(.small)) {
            LeftRightViewHStack(
                content: textContent,
                leftView: decrementButton,
                rightView: incrementButton
            )
            .textStyle(TextStyle.Regular())
            .stackStyle(StackStyle.RoundedRect(isError: !errorMessage.isEmpty))
        }
        .onChange(of: text, perform: onEditedChange)
    }

    func textContent() -> some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
    }

    func onEditedChange(_ text: String) {
        guard let number = Float(text) else {
            errorMessage = ""
            return
        }
        if let min = min, number < min {
            self.text = "\(min)"
        } else if let max = max, number > max {
            self.text = "\(max)"
        }
        errorMessage = ""
    }

    func decrementButton() -> some View {
        Button(action: decrement) {
            Image("minus")
        }
        .disabled(Float(text) == nil || (min != nil && Float(text)! <= min!))
    }

    func decrement() {
        var substrings = text.split(separator: ".")
        substrings[0] = "\(Int(substrings[0])! - 1)"
        text = substrings.joined(separator: ".")
    }

    func incrementButton() -> some View {
        Button(action: increment) {
            Image("plus")
        }
        .disabled(Float(text) == nil || (max != nil && Float(text)! >= max!))
    }

    func increment() {
        var substrings = text.split(separator: ".")
        substrings[0] = "\(Int(substrings[0])! + 1)"
        text = substrings.joined(separator: ".")
    }
}

struct FormNumberIncrementTestField: View {
    @State private var text: String = "5.0"
    @State private var errorMessage = "Error"
    
    var body: some View {
        FormNumberIncrementField(
            title: "Quantity",
            text: $text,
            min: 1,
            max: 9,
            errorMessage: $errorMessage
        )
    }
}

struct FormNumberIncrementField_Previews: PreviewProvider {
    static var previews: some View {
        FormNumberIncrementTestField()
    }
}
