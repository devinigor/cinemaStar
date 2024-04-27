// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// протокол DetailViewModel
protocol DetailViewModelProtocol: AnyObject {
    /// Замыкание с моделью данных
    var updateViewDetailCinemaHadler: ((DetailData) -> ())? { get set }
    /// Замыкание для избранного
    var favoritesHandler: BoolHandler? { get set }
    /// Запрос в сеть на получение деталей фильма
    func fetchDetail()
    /// Проверка фильма на фаворит
    func checkFavorite()
    /// Сохранение в фавориты
    func saveFaforites()
}

/// ViewModel для детального экрана
final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewDetailCinemaHadler: ((DetailData) -> ())?

    public var favoritesHandler: BoolHandler?

    // MARK: - Private Properties

    private let servis = FavoritesService.shared
    private weak var networkService: NetworkServiceProtocol?
    private var id: Int

    init(id: Int, networkService: NetworkServiceProtocol?) {
        self.networkService = networkService
        self.id = id
        updateViewDetailCinemaHadler?(.initial)
        servis.loadFavorites()
    }

    func checkFavorite() {
        if servis.favorites.firstIndex(of: id) != nil {
            favoritesHandler?(true)
        } else {
            favoritesHandler?(false)
        }
    }

    func saveFaforites() {
        if let cinema = servis.favorites.firstIndex(of: id) {
            servis.favorites.remove(at: cinema)
        } else {
            servis.favorites.append(id)
        }
        servis.saveFavorites()
    }

    // MARK: - Public Methods

    public func fetchDetail() {
        updateViewDetailCinemaHadler?(.loading)
        networkService?.getDetail(id: id, withCompletion: { [weak self] result in
            guard let self else { return }
            guard let result else { return }
            DispatchQueue.main.async {
                self.updateViewDetailCinemaHadler?(.success(result))
                self.checkFavorite()
            }
        })
    }
}
