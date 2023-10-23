//
//  View+ListStyle.swift
//  TWC
//
//  Created by Jacky Lam on 14/12/2021.
//

import SwiftUI

extension View {
    func listStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct ListStyle {
    struct Default: ViewModifier {
        func body(content: Content) -> some View {
            if #available(iOS 16.0, *) {
                content
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
            } else {
                content
                    .listStyle(PlainListStyle())
                    .onAppear {
                        UITableView.appearance().separatorColor = .clear
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableView.appearance().showsVerticalScrollIndicator = false
                    }
                    .onDisappear(perform: {
                        UITableView.appearance().separatorStyle = .singleLine
                    })
            }
        }
    }
}
