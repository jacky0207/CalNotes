//
//  FormView.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FormView<Content: View>: View {
    var title: String
    @Binding var errorMessage: String
    var content: () -> Content

    init(
        title: String,
        errorMessage: Binding<String>,
        content: @escaping () -> Content
    ) {
        self.title = title
        self._errorMessage = errorMessage
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FormHeaderView(title: title)
            content()
            FormFooterView(errorMessage: errorMessage)
        }
    }
}

struct FormField<T> where T: Encodable {
    var value: T
    var errorMessage: String

    init(
        _ value: T,
        errorMessage: String = ""
    ) {
        self.value = value
        self.errorMessage = errorMessage
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
    var errorMessage: String

    var body: some View {
        if errorMessage.isEmpty {
           EmptyView()
        } else {
            Spacer().frame(height: 2)
            FormerrorMessageView(errorMessage: errorMessage)
        }
    }
}

struct FormerrorMessageView: View {
    var errorMessage: String

    var body: some View {
        Text(errorMessage)
            .textStyle(TextStyle.FormError())
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormView(
                title: "Last Name",
                errorMessage: .constant("")
            ) {
                TextField("", text: .constant("Alvin"))
            }
            .previewDisplayName("Info")
            
            FormView(
                title: "Last Name",
                errorMessage: .constant("Please enter")
            ) {
                TextField("", text: .constant("Alvin"))
            }
            .previewDisplayName("Error")
        }
        .previewLayout(.sizeThatFits)
    }
}
