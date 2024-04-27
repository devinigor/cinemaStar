// CinemaViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фильмом для коллекции
final class CinemaViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 8
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    let identefire = "CiemaCell"

    // MARK: - Visual Components

    private lazy var posterImageView: UIImageView = {
        let button = UIImageView()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.font = UIFont(name: Constants.fontVerdana, size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupConstraints()
    }

    // MARK: - Public Methods

    func configure(dto: CinemaDto) {
        DispatchQueue.global().async {
            self.posterImageView.download(from: dto.poster)
        }
        nameCategoryLabel.text = "⭐\n" + "\(dto.raiting.rounded(.towardZero))"
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameCategoryLabel)
    }

    @objc private func pushCategory() {
        debugPrint("push")
    }
}

// MARK: - RecipiesViewCell + Constraints

private extension CinemaViewCell {
    func setupConstraints() {
        setupCategoryButtonConstraints()
        setupNameCategoryConstraints()
    }

    func setupCategoryButtonConstraints() {
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
    }

    func setupNameCategoryConstraints() {
        nameCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameCategoryLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8).isActive = true
        nameCategoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
