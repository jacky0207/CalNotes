//
//  HomeViewModel.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-29.
//

import Foundation
import Combine

class HomeViewModel: ViewModel, ObservableObject, HomeProtocol {
    @Published var home: Home = .none

    override func loadData() {
        super.loadData()
        getHome()
    }

    func getHome() {
        dataService.getHome()
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(apiError) = completion else {
                        return
                    }
                    AppState.shared.setAlert(for: AlertParams(
                        title: apiError.errorMessage
                    ))
                },
                receiveValue: { home in
                    self.home = home
                }
            )
            .store(in: &cancellables)
    }
}

#if DEBUG
extension HomeViewModel {
    convenience init(preview: Bool) {
        self.init(diContainer: DIContainer())
        if preview {
            home = ModelData().home
        }
    }
}
#endif
