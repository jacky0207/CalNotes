//
//  ImagePicker.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-22.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct ImagePicker: View {
    @Binding var image: Optional<UIImage>
    @State private var isShowSourceTypeSelections = false
    @State private var isShowPickerView = false
    @State private var isShowPermissionDenied = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    init(image: Binding<Optional<UIImage>>) {
        self._image = image
    }

    var body: some View {
        Button(action: { isShowSourceTypeSelections = true }) {
            if let image = image {
                ImageEditPicker(
                    image: image,
                    removeAction: { self.image = nil }
                )
            } else {
                ImageNewPicker()
            }
        }
        .confirmationDialog("", isPresented: $isShowSourceTypeSelections, titleVisibility: .hidden) {
            Button("camera", role: nil, action: cameraAction)
            Button("photo_library", role: nil, action: photoLibraryAction)
        }
        .sheet(isPresented: $isShowPickerView) {
            ImagePickerView(
                sourceType: sourceType,
                selectedImage: $image
            )
        }
        .alert("permission_denied", isPresented: $isShowPermissionDenied) {
            Button("ok", action: {})
        }
    }

    func cameraAction() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    sourceType = .camera
                    isShowPickerView = true
                }
            }
        case .authorized:
            sourceType = .camera
            isShowPickerView = true
        default:
            isShowPermissionDenied = true
        }
    }

    func photoLibraryAction() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized, .limited:
                    sourceType = .photoLibrary
                    isShowPickerView = true
                default:
                    isShowPermissionDenied = true
                }
            }
        case .authorized, .limited:
            sourceType = .photoLibrary
            isShowPickerView = true
        default:
            isShowPermissionDenied = true
        }
    }
}

struct ImageNewPicker: View {
    var body: some View {
        VStack {
            Image("plus2")
                .resizable()
                .imageStyle(ImageStyle.IconXLarge())
        }
        .frame(maxWidth: .infinity, minHeight: Dimen.float(.imagePickerHeight))
    }
}


struct ImageEditPicker: View {
    var image: UIImage
    var removeAction: (() -> Void)

    var body: some View {
        ZStack {
            preview()
            removeButton()
        }
        .frame(maxWidth: .infinity, maxHeight: Dimen.float(.imagePickerHeight))
    }

    func preview() -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .background(Color.blue)
    }

    func removeButton() -> some View {  // align top-right corner
        VStack {
            Spacer().frame(height: Dimen.spacing(.large))
            HStack() {
                Spacer()
                Button(action: removeAction) {
                    Image("close")
                        .resizable()
                        .imageStyle(ImageStyle.Icon())
                }
                Spacer().frame(width: Dimen.spacing(.large))
            }
            Spacer()
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImagePicker(image: .constant(nil))
            ImagePicker(image: .constant(UIImage(named: "logo")))
        }
    }
}
