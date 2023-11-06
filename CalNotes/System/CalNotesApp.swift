//
//  CalNotesApp.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

import SwiftUI
import Firebase
import FirebaseCore
import GoogleMobileAds


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if CommandLine.arguments.contains("testing") {
            UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.layer
                .speed = 100
            UIView.setAnimationsEnabled(false)
            try! CoreDataHelper.shared.deleteAll()
        }
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "58b275a6b31f16860f67b79e0ae050fd" ]
        return true
    }
}

@main
struct CalNotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let diContainer = DIContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.defaultMinListRowHeight, 1)  // set list row min height to all pages, having bug if min height is 0
                .environment(\.diContainer, diContainer)
        }
    }
}
