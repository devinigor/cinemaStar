// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    override func start() {
        cinemaMain()
    }

    // MARK: - Private Methods

    private func cinemaMain() {
        let cinemaInteractor = CinemaInteractor()
        let detailPresenter = DetailPresenter()
        let cinemaRouter = CinemaRouter(detailPresenter: detailPresenter)
        let detailInteractor = DetailInteractor()
        detailPresenter.interactor = detailInteractor
        detailInteractor.detailPresenter = detailPresenter
        let cinemaPresenter = CinemaPresenter(cinemaInteractor: cinemaInteractor, router: cinemaRouter)
        cinemaInteractor.cinemaPresenter = cinemaPresenter
        let viewController = UIViewController()
        let hostingController = UIHostingController(rootView: StartCinemaView(cinemaPresenter: cinemaPresenter))
        viewController.view.addSubview(hostingController.view)
        hostingController.view.frame = UIScreen.main.bounds
        setAsRoot​(​_​: viewController)
    }
}
