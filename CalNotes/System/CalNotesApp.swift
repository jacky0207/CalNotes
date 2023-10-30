//
//  CalNotesApp.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct CalNotesApp: App {
    let diContainer = DIContainer()

    init() {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "5015e1e051150192c2f5bda128f1cf0f" ]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.defaultMinListRowHeight, 1)  // set list row min height to all pages, having bug if min height is 0
                .environment(\.diContainer, diContainer)
        }
    }
}
