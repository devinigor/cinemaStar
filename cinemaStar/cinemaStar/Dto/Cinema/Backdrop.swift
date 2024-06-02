// Backdrop.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель постера полученнея из интеренета
struct Backdrop: Codable {
    /// Ссылка на постер
    let url, previewURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}
