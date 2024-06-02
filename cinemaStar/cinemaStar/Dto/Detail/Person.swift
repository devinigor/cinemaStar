// Person.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель из интернет с актерами
struct Person: Codable {
    /// ID
    let id: Int
    /// Фото актера
    let photo: String
    /// Имя актера
    let name: String
    /// Описание актера
    let description: String?
}
