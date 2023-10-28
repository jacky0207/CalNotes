//
//  FormNumberIncrementField.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-28.
//

import SwiftUI

struct FormNumberIncrementField: View {
    var title: String
    @Binding var number: Int
    var min: Int
    var max: Int
    @Binding var errorMessage: String

    var text: Binding<String> {
        return Binding(
            get: { "\($number.wrappedValue)" },
            set: { $number.wrappedValue = Int($0) ?? 0 }
        )
    }

    init(
        title: String = "",
        number: Binding<Int>,
        min: Int = 0,
        max: Int = Int.max,
        errorMessage: Binding<String> = .constant("")
    ) {
        self.title = title
        self._number = number
        self.min = min
        self.max = max
        self._errorMessage = errorMessage
    }

    init(
        title: String = "",
        placeholder: String = "",
        field: Binding<FormField<Int>>,
        min: Int = 0,
        max: Int = Int.max
    ) {
        self.init(
            title: title,
            number: Binding(
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
            Button(action: decrement) {
                Image("minus")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
            .buttonStyle(FilledButtonStyle())
            .disabled(number <= min)

            LeftRightViewHStack {
                TextField("", text: text)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            }
            .textStyle(TextStyle.Regular())
            .stackStyle(StackStyle.RoundedRect(isError: !errorMessage.isEmpty))

            Button(action: increment) {
                Image("plus")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
            .buttonStyle(FilledButtonStyle())
            .disabled(number >= max)
        }
        .onChange(of: number) { _ in
            if number < min {
                number = min
            } else if number > max {
                number = max
            }
            errorMessage = ""
        }
    }

    func decrement() {
        number -= 1
    }

    func increment() {
        number += 1
    }
}

struct FormNumberIncrementTestField: View {
    @State private var number = 5
    @State private var errorMessage = "Error"
    
    var body: some View {
        FormNumberIncrementField(
            title: "Quantity",
            number: $number,
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
