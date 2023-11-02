//
//  View+StackStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

extension View {
    func stackStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct StackStyle {
    struct Alert: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
                .padding(.all, Dimen.spacing(.large))
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .fill(ColorStyle.noteBackground.color)
                        .shadow(
                            color: ColorStyle.shadow.color.opacity(Double(Dimen.float(.shadowAlpha))),
                            radius: Dimen.corner(.small),
                            x: Dimen.float(.shadowOffsetX),
                            y: Dimen.float(.shadowOffsetY)
                        )

                )
        }
    }

    struct Note: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.all, Dimen.spacing(.large))
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.xxLarge))
                        .fill(ColorStyle.noteBackground.color)
                        .shadow(
                            color: ColorStyle.shadow.color.opacity(Double(Dimen.float(.shadowAlpha))),
                            radius: Dimen.corner(.small),
                            x: Dimen.float(.shadowOffsetX),
                            y: Dimen.float(.shadowOffsetY)
                        )

                )
        }
    }

    struct NoteItem: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.all, Dimen.spacing(.large))
                .background(
                    Rectangle()
                        .fill(ColorStyle.itemBackground.color)
                        .border(Color.black, width: Dimen.border(.small))
                )
        }
    }

    struct RoundedRect: ViewModifier {
        @FocusState var isFocused: Bool
        var isError: Bool = false
        var paddingInsets: EdgeInsets = EdgeInsets(
            top: Dimen.spacing(.normal),
            leading: Dimen.spacing(.large),
            bottom: Dimen.spacing(.normal),
            trailing: Dimen.spacing(.large)
        )

        func body(content: Content) -> some View {
            content
                .focused($isFocused)
                // padding
                .padding(paddingInsets)
                // background
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .fill(Color.white)
                )
                // border
                .overlay(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .strokeBorder(
                            isError ? ColorStyle.errorPrimary.color : (isFocused ? ColorStyle.primary.color : ColorStyle.secondary.color),
                            style: StrokeStyle(
                                lineWidth: Dimen.border(.normal)
                            )
                        )
                )
        }
    }

    struct SettingsItem: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.all, Dimen.spacing(.large))
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.xxLarge))
                        .fill(ColorStyle.itemBackground.color)
                        .shadow(
                            color: ColorStyle.shadow.color.opacity(Double(Dimen.float(.shadowAlpha))),
                            radius: Dimen.corner(.small),
                            x: Dimen.float(.shadowOffsetX),
                            y: Dimen.float(.shadowOffsetY)
                        )

                )
        }
    }

    struct SectionFooter: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.all, Dimen.spacing(.large))
                .background(ColorStyle.footerBackground.color)
                .shadow(
                    color: ColorStyle.shadow.color.opacity(Double(Dimen.float(.shadowAlphaLarge))),
                    radius: Dimen.corner(.small),
                    x: Dimen.float(.shadowOffsetX),
                    y: -Dimen.float(.shadowOffsetY)
                )
        }
    }
}
