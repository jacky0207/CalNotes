//
//  LazyView.swift
//  TWC
//
//  Created by Jacky Lam on 18/2/2022.
//

import SwiftUI

// Use this to delay instantiation when using `NavigationLink`, etc...
// Reference: https://stackoverflow.com/a/60295011
struct LazyView<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        self.content()
    }
}

struct NavigationViewLink<Content: View, Label: View>: View {
    var destination: () -> Content
    var action: (@escaping () -> Void) -> Void
    var label: () -> Label
    @State private var isActive = false

    init(
        @ViewBuilder destination: @escaping () -> Content,
        action: @escaping (@escaping () -> Void) -> Void = { $0() },
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.destination = destination
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button(action: { action({ self.isActive.toggle() }) }) {
            label()
        }
        .navigationLinkBackground(
            destination: destination,
            isActive: $isActive
        )
    }
}

extension View {
    func navigationLinkBackground<Content: View>(
        destination: @escaping () -> Content,
        isActive: Binding<Bool>
    ) -> some View {
        self.background(
            NavigationLink(
                destination: LazyView {
                    UIApplication.shared.windows.first?.endEditing(true)  // dismiss keyboard before navigation
                    return destination()
                },
                isActive: isActive,
                label: { EmptyView() }
            )
            .disabled(true)
            .opacity(0)
        )
    }
}

#if DEBUG
struct NavigationViewLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationViewLink(destination: { EmptyView() }) {
                Text("Test")
            }
        }
    }
}
#endif
