//
//  AlertView.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI
import Combine

struct AlertParams {
    var title: String
    var message: String

    init(
        title: String,
        message: String = ""
    ) {
        self.title = title
        self.message = message
    }
}

extension AlertParams {
    static var none: AlertParams {
        return AlertParams(title: "", message: "")
    }
}

extension View {
    func alert(for params: AlertParams, isPresented: Binding<Bool>) -> some View {
        self.alert(params.title, isPresented: isPresented, actions: {
            Button("ok", action: {})
        }, message: {
            Text(params.message)
        })
    }
}

struct AlertView<Content: View>: View {
    var isPresented: Binding<Bool>
    var title: String
    var action: Optional<() -> Void>
    var actionDisabled: Bool
    var content: () -> Content

    init(
        isPresented: Binding<Bool>,
        title: String,
        action: Optional<() -> Void> = nil,
        actionDisabled: Bool = false,
        content: @escaping () -> Content
    ) {
        self.isPresented = isPresented
        self.title = title
        self.action = action
        self.actionDisabled = actionDisabled
        self.content = content
    }

    init(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        action: Optional<() -> Void> = nil,
        actionDisabled: Bool = false
    ) where Content == Text {
        self.isPresented = isPresented
        self.title = title
        self.action = action
        self.actionDisabled = actionDisabled
        self.content = {
            Text(message)
        }
    }

    var body: some View {
        ZStack {
            ColorStyle.alertBackground.color
                .opacity(0.5)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: Dimen.spacing(.normal)) {
                AlertHeaderView(title: title)
                content()
                AlertFooterView(isPresented: isPresented, action: action, actionDisabled: actionDisabled)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .stackStyle(StackStyle.Alert())
            .padding(.horizontal, Dimen.spacing(.horizontalMargin))
        }
    }
}

struct AlertHeaderView: View {
    var title: String

    var body: some View {
        Text(title)
            .textStyle(TextStyle.FormSectionTitle())
    }
}

struct AlertFooterView: View {
    var isPresented: Binding<Bool>
    var action: Optional<() -> Void>
    var actionDisabled: Bool

    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            if action == nil {
                Button("ok", action: positiveAction)
                    .buttonStyle(RoundedRectButtonStyle(maxWidth: .infinity))
            } else {
                Button("ok", action: positiveAction)
                    .buttonStyle(RoundedRectButtonStyle())
                    .disabled(actionDisabled)

                Spacer()

                Button("cancel", action: negativeAction)
                    .buttonStyle(RoundedRectButtonStyle())
            }
        }
    }

    func positiveAction() {
        isPresented.wrappedValue = false
        action?()
    }

    func negativeAction() {
        isPresented.wrappedValue = false
    }
}

struct AlertView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            AlertView(isPresented: .constant(true), title: "Title", action: nil) {
                Text("Hello, World!")
            }
            AlertView(isPresented: .constant(true), title: "Title", action: {}) {
                Text("Hello, World!")
            }
        }
    }
}
