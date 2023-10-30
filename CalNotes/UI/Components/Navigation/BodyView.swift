//
//  BodyView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct BodyView<Content: View, ToolbarLeading: View, ToolbarTrailing: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    var toolbarLeading: () -> ToolbarLeading
    var toolbarTrailing: () -> ToolbarTrailing
    var content: () -> Content

    init(
        title: String,
        @ViewBuilder toolbarLeading: @escaping () -> ToolbarLeading = { EmptyView() },
        @ViewBuilder toolbarTrailing: @escaping () -> ToolbarTrailing = { EmptyView() },
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.toolbarLeading = toolbarLeading
        self.toolbarTrailing = toolbarTrailing
        self.content = content
    }

    init(
        title: String,
        @ViewBuilder toolbar: @escaping () -> ToolbarTrailing,
        @ViewBuilder content: @escaping () -> Content
    ) where ToolbarLeading == EmptyView {
        self.init(
            title: title,
            toolbarLeading: { EmptyView() },
            toolbarTrailing: toolbar,
            content: content
        )
    }

    var body: some View {
        content()
            .navigationBarTitle(Text(LocalizedStringKey(title)), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if ToolbarLeading.self != EmptyView.self || !presentationMode.wrappedValue.isPresented {
                        toolbarLeading()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing, content: toolbarTrailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorStyle.background.color)
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                BodyView(title: "notes") {
                    Text("Hello, world!")
                }
            }
            .navigationViewStyle(NavigationViewStyle.Default())

            NavigationView {
                BodyView(
                    title: "notes",
                    toolbar: {
                        NavigationViewLink(destination: { EmptyView() }) {
                            Text("Add")
                        }
                    }
                ) {
                    Text("Hello, world!")
                }
            }
            .navigationViewStyle(NavigationViewStyle.Default())
            .previewDisplayName("Navigation Bar View With Toolbar")
        }
    }
}
