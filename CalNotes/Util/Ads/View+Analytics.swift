//
//  View+Analytics.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-11-12.
//

import SwiftUI
import FirebaseAnalytics

extension View {
    func analyticsScreen<Class: View>(_ class: Class) -> some View {
        self.onAppear() {
            Analytics.logEvent(
                AnalyticsEventScreenView,
                parameters: [
                    AnalyticsParameterScreenName: "\(type(of: `class`))",
                    AnalyticsParameterScreenClass: "\(type(of: `class`))"
                ]
            )
        }
    }
}
