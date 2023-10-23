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
    @Binding var errorMessage: String
    @State private var isShowSourceTypeSelections = false

    init(
        title: String = "",
        image: Binding<Optional<UIImage>>,
        errorMessage: Binding<String> = .constant("")
    ) {
        self.title = title
        self._image = image
        self._errorMessage = errorMessage
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
        ImagePicker(image: $image)
            .onChange(of: image) { _ in
                errorMessage = ""
            }
    }
}

struct FormImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        FormImagePicker(
            title: "Last Name",
            image: .constant(nil),
            errorMessage: .constant("Please enter \"Tai Man\" for \"Chan Tai Man\"")
        )
        .previewLayout(.sizeThatFits)
    }
}
