//
//  ImagePreviewView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-22.
//

import SwiftUI

// Reference: https://gist.github.com/pitt500/472c261ca32bf1feca8dd5b35ecbd376
struct ImagePreviewView: View {
    var title: String
    let image: UIImage

    var body: some View {
        BodyView(
            title: title,
            toolbarTrailing: { ImagePreviewToolBar(title: title, image: image) },
            content: { ScalableImage(image: image) }
        )
    }
}

struct ImagePreviewToolBar: View {
    var title: String
    var image: UIImage

    var body: some View {
        Button(
            action: shareImage,
            label: { Image("share").resizable().imageStyle(ImageStyle.Icon()) }
        )
    }

    func shareImage() {
       let AV = UIActivityViewController(activityItems: [image], applicationActivities: nil)

       let scenes = UIApplication.shared.connectedScenes
       let windowScene = scenes.first as? UIWindowScene

       windowScene?.keyWindow?.rootViewController?.present(AV, animated: true, completion: nil)
    }
}

struct ScalableImage: View {
    var image: UIImage
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .gesture(magnification)
    }

    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { state in
                adjustScale(from: state)
            }
            .onEnded { state in
                withAnimation {
                    validateScaleLimits()
                }
                lastScale = 1.0
            }
    }

    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }

    func getMinimumScaleAllowed() -> CGFloat {
        return max(scale, minScale)
    }

    func getMaximumScaleAllowed() -> CGFloat {
        return min(scale, maxScale)
    }

    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
}

#if DEBUG
struct ImagePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BodyView(title: "Logo") {
                ImagePreviewView(title: "Logo", image: UIImage(named: "logo") ?? UIImage())
            }
        }
    }
}
#endif
