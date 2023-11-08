//
//  HomeView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-29.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.diContainer) var diContainer
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        BodyView(
            title: "home",
            titleDisplayType: .large,
            content: content
        )
        .onAppear(perform: viewModel.loadData)
        .safeAreaInset(edge: .bottom) {
            BannerView()
                .frame(height: 60)
                .background(ColorStyle.background.color)
        }
    }

    func content() -> some View {
        VStack(spacing: Dimen.spacing(.xLarge)) {
            Group {
                HomeNotesView(
                    note: viewModel.home.note,
                    trash: viewModel.home.trash
                )
                HomeSettingsView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .contain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(
            top: Dimen.spacing(.topMargin),
            leading: Dimen.spacing(.horizontalMargin),
            bottom: Dimen.spacing(.bottomMargin),
            trailing: Dimen.spacing(.horizontalMargin)
        ))
        .accessibilityElement(children: .contain)
    }
}

struct HomeNotesView: View {
    @Environment(\.diContainer) var diContainer
    var note: Int
    var trash: Int

    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.spacing(.small)) {
            Text("notes")
                .textStyle(TextStyle.SectionTitle())
            HStack(spacing: Dimen.spacing(.normal)) {
                noteButton()
                trashButton()
            }
            .accessibilityElement(children: .contain)
        }
        .accessibilityElement(children: .contain)
    }

    func noteButton() -> some View {
        NavigationViewLink(
            destination: { NoteListView(viewModel: NoteListViewModel(diContainer: diContainer)) },
            label: {
                SettingsItemView(
                    title: "notes".localized(),
                    value: "\(note)",
                    leadingIcon: Image("note")
                )
                .accessibilityAddTraits(.isButton)
                .accessibilityIdentifier("noteListButton")
            }
        )
    }

    func trashButton() -> some View {
        NavigationViewLink(
            destination: { NoteTrashView(viewModel: NoteTrashViewModel(diContainer: diContainer)) },
            label: {
                SettingsItemView(
                    title: "note_trash".localized(),
                    value: "\(trash)",
                    leadingIcon: Image("trash")
                )
                .accessibilityAddTraits(.isButton)
                .accessibilityIdentifier("noteTrashButton")
            }
        )
    }
}

struct HomeSettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.spacing(.small)) {
            Text("settings")
                .textStyle(TextStyle.SectionTitle())
            HStack(spacing: Dimen.spacing(.normal)) {
                versionButton()
            }
        }
    }

    func versionButton() -> some View {
        SettingsItemView(
            title: "version".localized(),
            value: BuildConfig.shared.appVersion,
            leadingIcon: Image("version")
        )
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(viewModel: HomeViewModel(preview: true))
        }
    }
}
#endif
