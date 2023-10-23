//
//  ViewStyle+TextField.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-03-26.
//

import SwiftUI

struct RoundedRectTextFieldStyle: TextFieldStyle {
    @FocusState var isFocused: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
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
                        isFocused ? ColorStyle.primary.color : ColorStyle.textPrimary.color,
                        style: StrokeStyle(
                            lineWidth: isFocused ? Dimen.border(.large) : Dimen.border(.normal)
                        )
                    )
            )
    }
}
