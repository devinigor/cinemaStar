// CinemaData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// CinemaData
enum CinemaData {
    /// Инициализация
    case initial
    /// Загрузка
    case loading
    /// Успешно
    case success([CinemaDto])
    /// Ошибка
    case failure
}
