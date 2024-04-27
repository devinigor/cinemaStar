// ViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  View Model Protocol
protocol MainViewModelProtocol: AnyObject {
    /// Замыкание
    var updateViewCinemaHandler: ((CinemaData) -> ())? { get set }
    /// Запрос в интернет
    func startFetch()
    /// Переход на экран с деталями
    func pushDetail(id: Int)
}

/// View Model
final class MainViewModel: MainViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewCinemaHandler: ((CinemaData) -> ())?

    // MARK: - Private Properties

    private weak var coordinator: CinemaCollectionCoordinator?
    private weak var networkService: NetworkServiceProtocol?

    // MARK: - Initializers

    init(coordinator: CinemaCollectionCoordinator, networkService: NetworkServiceProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
        updateViewCinemaHandler?(.initial)
    }

    // MARK: - Public Properties

    public func startFetch() {
        networkService?.getFilm(withCompletion: { [weak self] result in
            self?.updateViewCinemaHandler?(.loading)
            guard let self else { return }
            guard let result else { return }
            DispatchQueue.main.async {
                self.updateViewCinemaHandler?(.success(result))
            }
        })
    }

    public func pushDetail(id: Int) {
        coordinator?.pushDetailViewController(id: id, networkService: networkService)
    }
}
