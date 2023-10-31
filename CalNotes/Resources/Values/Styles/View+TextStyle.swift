//
//  View+TextStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

extension View {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct TextStyle {
    struct Regular: ViewModifier {
        var foregroundColor: Color = ColorStyle.textPrimary.color
        var fontSize: FontSize = .normal

        func body(content: Content) -> some View {
            content
                .foregroundColor(foregroundColor)
                .font(FontStyle.regular.notoSansTC(for: fontSize))
        }
    }

    struct Medium: ViewModifier {
        var foregroundColor: Color = ColorStyle.textPrimary.color
        var fontSize: FontSize = .normal

        func body(content: Content) -> some View {
            content
                .foregroundColor(foregroundColor)
                .font(FontStyle.medium.notoSansTC(for: fontSize))
        }
    }

    struct Bold: ViewModifier {
        var foregroundColor: Color = ColorStyle.textPrimary.color
        var fontSize: FontSize = .normal
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(foregroundColor)
                .font(FontStyle.bold.notoSansTC(for: fontSize))
        }
    }
}

// MARK: - Form
extension TextStyle {
    struct FormSectionTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Bold(fontSize: .xLarge))
        }
    }

    struct FormTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Medium())
        }
    }

    struct FormPlaceholder: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Regular(foregroundColor: ColorStyle.hintPrimary.color))
        }
    }

    struct FormError: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Regular(foregroundColor: ColorStyle.errorPrimary.color))
        }
    }
}

// MARK: - Section
extension TextStyle {
    struct SectionTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Bold(fontSize: .xLarge))
        }
    }

    struct SectionFooterTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .textStyle(TextStyle.Bold(foregroundColor: ColorStyle.textSecondary.color, fontSize: .normal))
        }
    }
}

// MARK: - Item
extension TextStyle {
    struct ItemTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.medium.notoSansTC(for: .normal))
        }
    }

    struct ItemText: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.regular.notoSansTC(for: .normal))
        }
    }
}
