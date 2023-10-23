//
//  View+TextEditorStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

extension View {
    func textEditorStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct TextEditorStyle {
    struct RoundedRect: ViewModifier {
        @FocusState var isFocused: Bool
        var isError: Bool = false
        
        func body(content: Content) -> some View {
            content
                .frame(height: Dimen.float(.textEditorHeight))
                .focused($isFocused)
                // text
                .font(FontStyle.regular.notoSansTC(for: .normal))
                .foregroundColor(ColorStyle.textPrimary.color)
                // padding
                .padding(EdgeInsets(
                    top: Dimen.spacing(.small),
                    leading: Dimen.spacing(.normal),
                    bottom: Dimen.spacing(.small),
                    trailing: Dimen.spacing(.normal)
                ))
                // background
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .fill(Color.white)
                )
                // border
                .overlay(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .strokeBorder(
                            isError ? ColorStyle.errorPrimary.color : (isFocused ? ColorStyle.primary.color : ColorStyle.textPrimary.color),
                            style: StrokeStyle(
                                lineWidth: isFocused ? Dimen.border(.large) : Dimen.border(.normal)
                            )
                        )
                )
        }
    }
}
