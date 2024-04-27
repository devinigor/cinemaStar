// CinemaCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор для коллекции фильмов
final class CinemaCollectionCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootController(viewController: UINavigationController) {
        rootViewController = viewController
    }

    func pushDetailViewController(id: Int, networkService: NetworkServiceProtocol?) {
        let detailViewModel = DetailViewModel(id: id, networkService: networkService)
        let detailCinemaViewController = DetailCinemaViewController(detailViewModel: detailViewModel)
        rootViewController?.pushViewController(detailCinemaViewController, animated: true)
    }
}
