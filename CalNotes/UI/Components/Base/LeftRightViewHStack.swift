//
//  LeftRightViewHStack.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct LeftRightViewHStack<Content: View, LeftView: View, RightView: View>: View {
    var content: () -> Content
    var leftView: () -> LeftView
    var rightView: () -> RightView

    init(
        content:  @escaping () -> Content,
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { EmptyView() }
    ) {
        self.content = content
        self.leftView = leftView
        self.rightView = rightView
    }

    var body: some View {
        HStack(spacing: 4) {
            leftView()
            content()
            rightView()
        }
    }
}

struct LeftRightViewHStack_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeftRightViewHStack(
                content: {
                    Text("Red")
                }
            )
            .previewLayout(.sizeThatFits)

            LeftRightViewHStack(
                content: {
                    Text("Red")
                },
                rightView: { Image("arrow_down") }
            )
            .previewLayout(.sizeThatFits)

            LeftRightViewHStack(
                content: {
                    TextField("", text: .constant("1.0"))
                },
                leftView: { Text("$") }
            )
            .previewLayout(.sizeThatFits)
        }
    }
}
