//
//  BottomSheet.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-27.
//

import SwiftUI

struct BottomSheet<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var backgroundColor: Color = .white
    var detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    var content: () -> Content

    func makeUIViewController(context: Context) -> some UIViewController {
        let backgroundView = UIViewController(nibName: nil, bundle: nil)
        backgroundView.view.backgroundColor = .clear
        return backgroundView
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            let sheetController = UIHostingController(rootView: content())
            sheetController.view.backgroundColor = UIColor(backgroundColor)
            if let sheet = sheetController.presentationController as? UISheetPresentationController {
                sheet.detents = detents
            }
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: BottomSheet

        init(parent: BottomSheet) {
            self.parent = parent
        }

        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
    }
}

extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        backgroundColor: Color = .white,
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        content: @escaping () -> Content
    ) -> some View {
        self.background(
            BottomSheet(
                isPresented: isPresented,
                backgroundColor: backgroundColor,
                detents: detents,
                content: content
            )
        )
    }
}

struct BottomTestSheet: View {
    @State private var isPresented = false
    @State private var sum = SumTextCalculator.defaultValue

    var body: some View {
        Button("Click", action: { isPresented.toggle() })
            .bottomSheet(isPresented: $isPresented) {
                Button("Hello World") {

                }
            }
    }
}

struct BottomSheet_Preview: PreviewProvider {
    static var previews: some View {
        BottomTestSheet()
    }
}
