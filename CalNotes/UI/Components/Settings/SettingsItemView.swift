//
//  SettingsItemView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-04.
//

import SwiftUI

struct SettingsItemView: View {
    var title: String
    var value: String?
    var leadingIcon: Image?
    var trailingIcon: Image?
    var action: (() -> Void)?

    init(
        title: String,
        value: String? = nil,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.value = value
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.action = action
    }

    var body: some View {
        Button(
            action: action ?? {},
            label: label
        )
        .allowsHitTesting(action != nil)
    }

    func label() -> some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            if let leadingIcon = leadingIcon {
                SettingsItemLeadingView(icon: leadingIcon)
            }
            SettingsItemTitleView(title)
            Spacer()
            if let value = value {
                SettingsItemValueView(value)
            }
            if let trailingIcon = trailingIcon {
                SettingsItemTrailingView(icon: trailingIcon)
            }
        }
        .stackStyle(StackStyle.SettingsItem())
    }
}

struct SettingsItemLeadingView: View {
    var icon: Image

    var body: some View {
        icon
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}

struct SettingsItemTitleView: View {
    var title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .textStyle(TextStyle.Medium())
    }
}

struct SettingsItemValueView: View {
    var value: String

    init(_ value: String) {
        self.value = value
    }

    var body: some View {
        Text(value)
            .textStyle(TextStyle.Medium())
    }
}
struct SettingsItemTrailingView: View {
    var icon: Image

    var body: some View {
        icon
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}


struct SettingItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsItemView(
                title: "Version",
                value: "1.0",
                leadingIcon: Image("version"),
                trailingIcon: Image("arrow_right")
            ) {

            }
            .previewDisplayName("Full Button")

            SettingsItemView(
                title: "Version",
                value: "1.0"
            )
            .previewDisplayName("Text Only Button")
        }
    }
}
