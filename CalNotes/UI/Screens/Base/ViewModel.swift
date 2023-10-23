//
//  ViewModel.swift
//  FirstSwiftUI
//
//  Created by Jacky Lam on 2023-04-03.
//

import Combine

open class ViewModel {
    var diContainer: DIContainer
    var cancellables = Set<AnyCancellable>()

    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    var dataService: DataService {
        return diContainer.dataService
    }

    func loadData() {
        
    }
}
