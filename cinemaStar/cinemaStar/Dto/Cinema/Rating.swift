// Rating.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рейтинг фильма полученных из сети
struct Rating: Codable {
    /// Рейтинг
    let kp: Double

    enum CodingKeys: String, CodingKey {
        case kp
    }
}
