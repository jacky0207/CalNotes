//
//  FormButton.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormButton: View {
    var titleKey: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: label
        )
        .buttonStyle(FilledButtonStyle())
    }

    func label() -> some View {
        FormButtonLabel(titleKey)
    }
}

struct FormButtonLabel: View {
    var titleKey: LocalizedStringKey

    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }

    var body: some View {
        Text(titleKey)
            .frame(maxWidth: .infinity)
    }
}

struct FormButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormButton(titleKey: "Submit") {

            }

            FormButtonLabel("Submit")
                .previewDisplayName("Label")
        }
        .previewLayout(.sizeThatFits)
    }
}
