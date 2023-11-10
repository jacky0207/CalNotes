//
//  FormSheet.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormSheet<Content: View>: View {
    private var submitEnabled: Bool
    var submitTitleKey: LocalizedStringKey
    var submit: () -> Void
    var submitDisabled: Bool
    var padding: EdgeInsets
    var content: () -> Content

    // without submit button
    init(
        padding: EdgeInsets = EdgeInsets(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.submitEnabled = false
        self.submitTitleKey = ""
        self.submit = {}
        self.submitDisabled = false
        self.padding = padding
        self.content = content
    }

    // with submit button
    init(
        submitTitleKey: LocalizedStringKey = "Submit",
        submit: @escaping () -> Void,
        submitDisabled: Bool = false,
        padding: EdgeInsets = EdgeInsets(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.submitEnabled = true
        self.submitTitleKey = submitTitleKey
        self.submit = submit
        self.submitDisabled = submitDisabled
        self.padding = padding
        self.content = content
    }

    var body: some View {
        List {
            Spacer().frame(height: padding.top)
                .listRowStyle(ListRowStyle.Default())

            HStack {
                Spacer().frame(width: padding.leading)
                VStack(alignment: .leading, spacing: Dimen.spacing(.small)) {
                    content()
                    if submitEnabled {
                        submitButton()
                    }
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .contain)
                Spacer().frame(width: padding.trailing)
            }
            .listRowStyle(ListRowStyle.Default())
            .accessibilityElement(children: .contain)

            Spacer().frame(height: Dimen.spacing(.bottomMargin))
                .listRowStyle(ListRowStyle.Default())
        }
        .listStyle(ListStyle.Default())
        .environment(\.defaultMinListRowHeight, 1)
        .accessibilityElement(children: .combine)
    }

    func submitButton() -> some View {
        FormSubmitButton(
            titleKey: submitTitleKey,
            action: submit
        )
        .disabled(submitDisabled)
    }
}

struct FormSheet_Previews: PreviewProvider {
    static var previews: some View {
        FormSheet(submit: {}, padding: EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)) {
            FormTextField(
                title: "Last Name",
                text: .constant("")
            )
            FormTextField(
                title: "First Name",
                text: .constant("")
            )
            FormTextField(
                title: "Nick Name",
                text: .constant("")
            )
            FormTextField(
                title: "Last Name",
                text: .constant("")
            )
            FormTextField(
                title: "First Name",
                text: .constant("")
            )
            FormTextField(
                title: "Nick Name",
                text: .constant("")
            )
            FormTextField(
                title: "Last Name",
                text: .constant("")
            )
            FormTextField(
                title: "First Name",
                text: .constant("")
            )
            FormTextField(
                title: "Nick Name",
                text: .constant("")
            )
        }
    }
}
