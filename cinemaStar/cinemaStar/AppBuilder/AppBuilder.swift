// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Билдер для сборки модулей
final class AppBuilder {
    private var networkService: NetworkServiceProtocol
    func makeCinemaViewController(coordinator: CinemaCollectionCoordinator) -> CinemaViewController {
        let mainView = MainViewModel(coordinator: coordinator, networkService: networkService)
        let view = CinemaViewController(viewModel: mainView)
        return view
    }

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
