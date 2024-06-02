// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDelegate(windowScene: windowScene)
    }

    private func configureSceneDelegate(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        let networkService = NetworkService()
        let builder = AppBuilder(networkService: networkService)
        applicationCoordinator = ApplicationCoordinator(appBuilder: builder)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        applicationCoordinator?.start()
    }
}
