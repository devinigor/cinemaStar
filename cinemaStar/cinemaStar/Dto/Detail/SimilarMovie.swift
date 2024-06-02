// SimilarMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель рекомендаций полученных из интернета
struct SimilarMovie: Codable {
    let id: Int
    /// Имя фильмя с рекомендации
    let name: String
    /// Тип фильма с рекомендации
    let type: String
    /// Постер фильмма с рекомендации
    let poster: Backdrop
}
