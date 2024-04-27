// CinemaDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильма для презентейшн слоя
final class CinemaDto {
    let id: Int
    /// Постер
    let poster: String
    /// Имя фильма
    let name: String
    /// Рейтинг
    let raiting: Float

    init(dto: Doc) {
        id = dto.id
        poster = dto.poster.url
        name = dto.name
        raiting = Float(round(dto.rating.kp * 10)) / 10
    }
}
