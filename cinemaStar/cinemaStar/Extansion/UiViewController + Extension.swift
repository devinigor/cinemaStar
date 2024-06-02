// UiViewController + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    /// добавляем градиент на вью
    func createGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(named: "topGradient")?.cgColor ?? "",
            UIColor(named: "bottomGradient")?.cgColor ?? UIColor.black.cgColor
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }

    /// Вызов алерта
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Упс!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
