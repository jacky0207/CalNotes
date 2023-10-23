//
//  SettingsViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-03.
//

import Foundation

class SettingsViewModel: ViewModel, ObservableObject, SettingsProtocol {

}

#if DEBUG
extension SettingsViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer())
        if preview {

        }
    }
}
#endif
