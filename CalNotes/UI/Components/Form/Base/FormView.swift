//
//  FormView.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormView<Content: View>: View {
    var title: String
    @Binding var message: String
    var messageType: FormMessageType
    var content: () -> Content

    init(
        title: String,
        message: Binding<String>,
        messageType: FormMessageType,
        content: @escaping () -> Content
    ) {
        self.title = title
        self._message = message
        self.messageType = messageType
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FormHeaderView(title: title)
            content()
            FormFooterView(message: message, messageType: messageType)
        }
    }
}

enum FormMessageType: Encodable {
    case error
    case info
}

struct FormField<T> where T: Encodable {
    var value: T
    var message: String
    var messageType: FormMessageType

    init(
        _ value: T,
        message: String = "",
        messageType: FormMessageType = .error
    ) {
        self.value = value
        self.message = message
        self.messageType = messageType
    }
}

extension UIImage: Encodable {
    public func encode(to encoder: Encoder) throws {
        
    }

    open override var description: String {
        return "[Image]"
    }
}

extension FormField: Encodable & CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

fileprivate struct FormHeaderView: View {
    var title: String

    var body: some View {
        if title.isEmpty {
            EmptyView()
        } else {
            FormTitleView(title: title)
            Spacer().frame(height: 2)
        }
    }
}

fileprivate struct FormTitleView: View {
    var title: String

    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .textStyle(TextStyle.FormTitle())
        }
    }
}

fileprivate struct FormFooterView: View {
    var message: String
    var messageType: FormMessageType

    var body: some View {
        if message.isEmpty {
           EmptyView()
        } else {
            Spacer().frame(height: 2)
            FormMessageView(message: message, messageType: messageType)
        }
    }
}

struct FormMessageView: View {
    var message: String
    var messageType: FormMessageType

    var body: some View {
        switch messageType {
        case .info:
            Text(message)
                .textStyle(TextStyle.FormInfo())
        case .error:
            Text(message)
                .textStyle(TextStyle.FormError())
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormView(
                title: "Last Name",
                message: .constant("e.g. Tai Man"),
                messageType: .info
            ) {
                TextField("", text: .constant("Alvin"))
            }
            .previewDisplayName("Info")
            
            FormView(
                title: "Last Name",
                message: .constant("e.g. Tai Man"),
                messageType: .error
            ) {
                TextField("", text: .constant("Alvin"))
            }
            .previewDisplayName("Error")
        }
        .previewLayout(.sizeThatFits)
    }
}
