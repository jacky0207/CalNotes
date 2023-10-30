//
//  View+ImageStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-29.
//

import SwiftUI

extension View {
    func imageStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct ImageStyle {
    struct Logo: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.logoWidth), height: Dimen.float(.logoWidth))
        }
    }

    struct Icon: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.iconWidth), height: Dimen.float(.iconWidth))
        }
    }

    struct IconSmall: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.iconSmallWidth), height: Dimen.float(.iconSmallWidth))
        }
    }

    struct IconLarge: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.iconLargeWidth), height: Dimen.float(.iconLargeWidth))
        }
    }

    struct IconXLarge: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.iconXLargeWidth), height: Dimen.float(.iconXLargeWidth))
        }
    }

    struct IconXXLarge: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: Dimen.float(.iconXXLargeWidth), height: Dimen.float(.iconXXLargeWidth))
        }
    }
}
