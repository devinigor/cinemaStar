// DetailCinemaTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячека с отображением постера и кнопкой "Смотреть"
final class DetailCinemaTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let titleButton = "Смотреть"
        static let colorButtom = UIColor(named: "bottomGradient")
    }

    // MARK: - Public Properties

    let identefire = "posterCell"

    // MARK: - Private Properties

    var callAllert: VoidHandler?

    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let poster = UIImageView()
        poster.frame = CGRect(x: 10, y: 10, width: 150, height: 150)
        return poster
    }()

    private lazy var watchingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.titleButton, for: .normal)
        button.backgroundColor = Constants.colorButtom
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(callAlert), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Methods

    func makeCell(handler: @escaping VoidHandler, dto: DetailsDto?) {
        callAllert = handler
        makeUI()
        DispatchQueue.global().async {
            self.posterImageView.download(from: dto?.poster ?? "")
        }
        makeConstreint()
    }

    private func makeUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(watchingButton)
        selectionStyle = .none
        contentView.addSubview(posterImageView)
    }

    private func makeConstreint() {
        makeButtonConstrient()
    }

    @objc private func callAlert() {
        callAllert?()
    }
}

// MARK: - Layout

extension DetailCinemaTableViewCell {
    private func makeButtonConstrient() {
        watchingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        watchingButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        watchingButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        watchingButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
