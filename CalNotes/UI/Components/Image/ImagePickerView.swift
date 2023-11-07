//
//  ImagePickerView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-22.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: Optional<UIImage>
    var onSelectedChange: (UIImage) -> Void

    init(
        sourceType: UIImagePickerController.SourceType,
        selectedImage: Binding<Optional<UIImage>>,
        onSelectedChange: @escaping (UIImage) -> Void = { _ in }
    ) {
        self.sourceType = sourceType
        self._selectedImage = selectedImage
        self.onSelectedChange = onSelectedChange
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if let image = image {
                parent.selectedImage = image
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {  // trigger after selectedImage updated
                    self.parent.onSelectedChange(image)
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
