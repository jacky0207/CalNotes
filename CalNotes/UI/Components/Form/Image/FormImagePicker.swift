//
//  FormImagePicker.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-21.
//

import SwiftUI

struct FormImagePicker: View {
    var title: String
    @Binding var image: Optional<UIImage>
    @Binding var message: String
    var messageType: FormMessageType
    @State private var isShowSourceTypeSelections = false

    init(
        title: String = "",
        image: Binding<Optional<UIImage>>,
        message: Binding<String> = .constant(""),
        messageType: FormMessageType = .info
    ) {
        self.title = title
        self._image = image
        self._message = message
        self.messageType = messageType
    }

    init(
        title: String = "",
        field: Binding<FormField<Optional<UIImage>>>
    ) {
        self.init(
            title: title,
            image: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            message: Binding(
                get: { field.wrappedValue.message },
                set: { field.wrappedValue.message = $0 }
            ),
            messageType: field.wrappedValue.messageType
        )
    }
    
    var body: some View {
        FormView(
            title: title,
            message: $message,
            messageType: messageType,
            content: content
        )
    }

    func content() -> some View {
        ImagePicker(image: $image)
            .onChange(of: image) { _ in
                message = ""
            }
    }
}

struct FormImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        FormImagePicker(
            title: "Last Name",
            image: .constant(nil),
            message: .constant("Please enter \"Tai Man\" for \"Chan Tai Man\"")
        )
        .previewLayout(.sizeThatFits)
    }
}
