// DetailsDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для презентейшн слоя с деталями
final class DetailsDto: Codable {
    /// Имя фильма
    let name: String
    /// Постер для фильма
    let poster: String
    /// Рейтинг фильма
    let rating: Float
    /// Описание для фильма
    let description: String
    /// Год выпуска
    let year: Int
    /// Страна
    let countries: String
    /// Тип фильма
    let type: String
    /// Актеры
    let persons: [Person]
    /// Язык фильма
    let spokenLanguages: String
    /// Название фильма рекомендации
    let similarMovies: [SimilarMovie]?

    init(dto: DetailCinema) {
        name = dto.name
        poster = dto.poster.url
        rating = Float(round(dto.rating.kp * 10)) / 10
        description = dto.description
        year = dto.year
        countries = dto.countries.first?.name ?? ""
        type = dto.type
        persons = dto.persons
        spokenLanguages = dto.spokenLanguages?.first?.name ?? ""
        similarMovies = dto.similarMovies
    }
}
