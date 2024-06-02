// DetailCinema.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель получаемая из интернета
struct DetailCinema: Codable {
    /// Название фильма
    let name: String
    /// Ссылка на постер
    let poster: Backdrop
    /// Рейтинг
    let rating: Rating
    /// Описание
    let description: String
    /// Год выпуска
    let year: Int
    /// Страна
    let countries: [Country]
    // Тип
    let type: String
    /// Актеры
    let persons: [Person]
    /// Языки
    let spokenLanguages: [SpokenLanguage]?
    /// Рекомендации
    let similarMovies: [SimilarMovie]?
}
