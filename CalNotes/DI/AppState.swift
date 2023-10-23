//
//  AppState.swift
//  TWC
//
//  Created by Jacky on 19/10/2021.
//

import Foundation
import Combine
import UIKit

enum LaunchState {
    case slash
    case main
}

class AppState: ObservableObject {
    static let shared = AppState()

    private init() {}
    
    // MARK: Launch
    @Published var launchState: LaunchState = .slash

    // MARK: Alert Message
    @Published var isAlertPresented = false
    private(set) var alertParams: AlertParams = AlertParams(title: "", message: "")

    func setAlert(for params: AlertParams) {
        alertParams = params
        isAlertPresented = true
    }
}
