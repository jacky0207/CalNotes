//
//  FormSubmitButton.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormSubmitButton: View {
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
        Text(titleKey)
            .frame(maxWidth: .infinity)
    }
}

struct FormSubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        FormSubmitButton(titleKey: "Submit") {
            
        }
    }
}
