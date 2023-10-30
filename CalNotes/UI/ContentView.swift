//
//  ContentView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.diContainer) var diContainer
    @ObservedObject var appState = AppState.shared

    var body: some View {
        ZStack {
            Group {
                switch appState.launchState {
                case .slash:
                    SlashView()
                case .main:
                    ContentMainView()
                }
            }

            if appState.isAlertPresented {
                AlertView(
                    isPresented: $appState.isAlertPresented,
                    title: appState.alertParams.title,
                    message: appState.alertParams.message,
                    action: nil
                )
            }
        }
    }
}

struct ContentMainView: View {
    @Environment(\.diContainer) var diContainer
    @State private var isInitLoaded = false
    @State private var isEnterNoteList = false
    
    var body: some View {
        ZStack {
            if #available(iOS 16, *) {
                NavigationStack(root: content)
                    .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad
                    .navigationViewStyle(NavigationViewStyle.Default())
                    .accentColor(ColorStyle.textPrimary.color)
            } else {
                NavigationView(content: content)
                    .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad
                    .navigationViewStyle(NavigationViewStyle.Default())
                    .accentColor(ColorStyle.textPrimary.color)
            }
        }
    }

    func content() -> some View {
        HomeView(viewModel: HomeViewModel(diContainer: diContainer))
            .navigationLinkBackground(
                destination: { NoteListView(viewModel: NoteListViewModel(diContainer: diContainer)) },
                isActive: $isEnterNoteList
            )
            .onAppear {
                if !isInitLoaded && !isEnterNoteList {
                    isEnterNoteList = true
                    isInitLoaded = true
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
