//
//  SettingsView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-03.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        BodyView(
            title: "settings",
            content: content
        )
    }

    func content() -> some View {
        VStack(spacing: Dimen.spacing(.normal)) {
            SettingsItemView(
                title: "version",
                value: BuildConfig.shared.appVersion,
                leadingIcon: Image("version")
            )
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(
            top: Dimen.spacing(.topMargin),
            leading: Dimen.spacing(.horizontalMargin),
            bottom: Dimen.spacing(.bottomMargin),
            trailing: Dimen.spacing(.horizontalMargin)
        ))
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(viewModel: SettingsViewModel(preview: true))
        }
        .navigationViewStyle(NavigationViewStyle.Default())
    }
}
#endif
