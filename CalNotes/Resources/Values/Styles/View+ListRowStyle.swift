//
//  View+ListRowStyle.swift
//  TWC
//
//  Created by Jacky Lam on 15/12/2021.
//

import SwiftUI

extension View {
    func listRowStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

extension Spacer {
    func listRowStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct ListRowStyle {
    struct Default: ViewModifier {
        func body(content: Content) -> some View {
            if #available(iOS 16.0, *) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets(top: -0.5, leading: 0, bottom: -0.5, trailing: 0))  // top inset for topmost separator line
                    .padding(EdgeInsets(top: 1.5, leading: 0, bottom: 1.5, trailing: 0))  // padding top for cancelling inset
                    .listRowBackground(Color.clear)
                    .background(Color.clear)
                    .listRowSeparator(.hidden)
            } else {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets(top: -0.5, leading: 0, bottom: -0.5, trailing: 0))  // top inset for topmost separator line
                    .padding(EdgeInsets(top: 1.5, leading: 0, bottom: 1.5, trailing: 0))  // padding top for cancelling inset
                    .listRowBackground(Color.clear)
                    .background(Color.clear)
            }
        }
    }

    struct forIOS14: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                 .frame(
                   minWidth: 0, maxWidth: .infinity,
                   minHeight: 44,
                   alignment: .leading
                 )
                 .listRowInsets(EdgeInsets())
                 .background(Color.clear)
        }
    }
}
