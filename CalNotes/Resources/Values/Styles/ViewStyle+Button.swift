//
//  ViewStyle+Button.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // text
            .font(FontStyle.medium.notoSansTC(for: .large))
            .foregroundColor(Color.white)
            // background
            .padding(EdgeInsets(
                top: Dimen.spacing(.small),
                leading: Dimen.spacing(.xxLarge),
                bottom: Dimen.spacing(.small),
                trailing: Dimen.spacing(.xxLarge)
            ))
            .background(isEnabled ? (
                configuration.isPressed ? ColorStyle.primaryHighlighted.color : ColorStyle.primary.color
            ) : ColorStyle.primaryDisabled.color)
            .cornerRadius(Dimen.corner(.normal))
    }
}

struct RoundedRectButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var maxWidth: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // frame
            .frame(maxWidth: maxWidth)
            .contentShape(Rectangle())  // provide hit area shape
            // text
            .font(FontStyle.medium.notoSansTC(for: .large))
            .foregroundColor(isEnabled ? (
                configuration.isPressed ? .white : ColorStyle.primary.color
            ) : ColorStyle.primaryDisabled.color)
            // padding
            .padding(EdgeInsets(
                top: Dimen.spacing(.small),
                leading: Dimen.spacing(.xxLarge),
                bottom: Dimen.spacing(.small),
                trailing: Dimen.spacing(.xxLarge)
            ))
            // background
            .background(
                RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                    .fill(configuration.isPressed ? ColorStyle.primaryHighlighted.color : .clear)
            )
            // border
            .cornerRadius(Dimen.corner(.normal))
            .overlay(
                RoundedRectangle(cornerRadius: Dimen.corner(.normal))
                    .strokeBorder(
                        isEnabled ? ColorStyle.primary.color : ColorStyle.primaryDisabled.color,
                        lineWidth: configuration.isPressed ? 0 : Dimen.border(.normal)
                    )
            )
    }
}
