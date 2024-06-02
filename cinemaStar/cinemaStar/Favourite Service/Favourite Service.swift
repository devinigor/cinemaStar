// Favourite Service.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для работы с избранным
protocol FavoritesServiceProtocol: AnyObject {
    /// Сохранение избранного
    func saveFavorites()
    /// Получение избранного
    func loadFavorites()
}

/// Сервис для работы с избранным
final class FavoritesService {
    // MARK: - Constants

    private enum Constants {
        static let favoriteKey = "FavoriteKey"
    }

    public enum Error: Swift.Error {
        case favoritesNo
    }

    static let shared = FavoritesService()

    var favorites: [Int] = []

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Initializers

    private init() {
        loadFavorites()
    }

    func saveFavorites() {
        do {
            let userData: Memento = try encoder.encode(favorites)
            UserDefaults.standard.set(userData, forKey: Constants.favoriteKey)
        } catch {}
    }

    func loadFavorites() {
        do {
            guard let userData = UserDefaults.standard.value(forKey: Constants.favoriteKey) as? Memento,
                  let fovorites = try? decoder.decode([Int].self, from: userData)
            else { throw Error.favoritesNo }
            favorites = fovorites
        } catch {}
    }
}
