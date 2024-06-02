// UiImageView + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    /// Расширение выполнения запроса по загрузке картинки
    /// - Parameter link: тип ссылки
    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        NetworkService().execute(url: url) { data in
            guard let data else { return }
            self.image = UIImage(data: data)
        }
    }
}
