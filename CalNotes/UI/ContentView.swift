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
    
    var body: some View {
        ZStack {
            if #available(iOS 16, *) {
                NavigationStack {
                    NoteListView(viewModel: NoteListViewModel(diContainer: diContainer))
                }
                .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad
                .navigationViewStyle(NavigationViewStyle.Default())
            } else {
                NavigationView {
                    NoteListView(viewModel: NoteListViewModel(diContainer: diContainer))
                }
                .navigationViewStyle(StackNavigationViewStyle())  // solve navigation view displayed as drawer in ipad
                .navigationViewStyle(NavigationViewStyle.Default())
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
