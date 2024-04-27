// Doc.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильма полученная из сети
struct Doc: Codable {
    /// Имя фильма
    let name: String
    /// Постер
    let poster: Backdrop
    /// рейтинг
    let rating, votes: Rating
    let id: Int
}
