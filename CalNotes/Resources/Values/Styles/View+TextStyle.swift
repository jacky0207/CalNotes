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
        var fontSize: FontSize = .normal

        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.regular.notoSansTC(for: fontSize))
        }
    }

    struct Medium: ViewModifier {
        var fontSize: FontSize = .normal

        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.medium.notoSansTC(for: fontSize))
        }
    }

    struct Bold: ViewModifier {
        var fontSize: FontSize = .normal
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.bold.notoSansTC(for: fontSize))
        }
    }

    struct NoteTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.bold.notoSansTC(for: .normal))
        }
    }

    struct ItemTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.bold.notoSansTC(for: .normal))
        }
    }

    struct SectionTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textSecondary.color)
                .font(FontStyle.bold.notoSansTC(for: .normal))
        }
    }

    struct FormSectionTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.bold.notoSansTC(for: .xLarge))
        }
    }

    struct FormTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(ColorStyle.textPrimary.color)
                .font(FontStyle.medium.notoSansTC(for: .normal))
        }
    }

    struct FormPlaceholder: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(FontStyle.regular.notoSansTC(for: .normal))
                .foregroundColor(ColorStyle.hintPrimary.color)
        }
    }

    struct FormError: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(FontStyle.regular.notoSansTC(for: .normal))
                .foregroundColor(ColorStyle.errorPrimary.color)
        }
    }
}
