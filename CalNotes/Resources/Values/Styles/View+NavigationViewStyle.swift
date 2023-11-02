//
//  View+NavigationViewStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

extension View {
    func navigationViewStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct NavigationViewStyle {
    struct Default: ViewModifier {
        init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()  // enable backgroundd color transparent
            appearance.backgroundColor = .clear
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()  // remove default shadow image
            appearance.titleTextAttributes = [
                .font: UIFont(name: FontStyle.NotoSansTC.bold.rawValue, size: FontSize.large.rawValue)!,
                .foregroundColor: UIColor(ColorStyle.textPrimary.color)
            ]
            appearance.largeTitleTextAttributes = [
                .font: UIFont(name: FontStyle.NotoSansTC.bold.rawValue, size: 36)!,
                .foregroundColor: UIColor(ColorStyle.textPrimary.color)
            ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        }
        
        func body(content: Content) -> some View {
            content
        }
    }
}
