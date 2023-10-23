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
                        .border(Color.black, width: Dimen.border(.normal))
                )
        }
    }

    struct RoundedRect: ViewModifier {
        @FocusState var isFocused: Bool

        func body(content: Content) -> some View {
            content
                .focused($isFocused)
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
                            isFocused ? ColorStyle.primary.color : ColorStyle.textPrimary.color,
                            style: StrokeStyle(
                                lineWidth: Dimen.border(.normal)
                            )
                        )
                )
        }
    }

    struct ImagePicker: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, minHeight: Dimen.float(.imagePickerHeight))
                // background
                .background(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .fill(Color.white)
                )
                // border
                .overlay(
                    RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                        .strokeBorder(
                            ColorStyle.textPrimary.color,
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
                .padding(.horizontal, Dimen.spacing(.xLarge))
                .padding(.vertical, Dimen.spacing(.large))
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
}
