// DetailData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DetailCinemaData
enum DetailData {
    /// Инициализация
    case initial
    /// загрузка
    case loading
    /// Успешно
    case success(DetailsDto)
    /// Ошибка
    case failure
}
