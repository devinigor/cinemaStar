// RecomendationCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рекомендациями для коллекции
final class RecomendationCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 8
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    let identefire = "collectionRecomendation"

    // MARK: - Visual Components

    private lazy var avatarActorImageView: UIImageView = {
        let button = UIImageView()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameActorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.font = UIFont(name: Constants.fontVerdana, size: 16)
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

    func configure(dto: SimilarMovie) {
        DispatchQueue.global().async {
            self.avatarActorImageView.download(from: dto.poster.url)
        }
        nameActorLabel.text = dto.name
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(avatarActorImageView)
        contentView.addSubview(nameActorLabel)
    }
}

// MARK: - RecomendationCollectionViewCell + Constraints

private extension RecomendationCollectionViewCell {
    func setupConstraints() {
        setupCategoryButtonConstraints()
        setupNameCategoryConstraints()
    }

    func setupCategoryButtonConstraints() {
        avatarActorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        avatarActorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        avatarActorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        avatarActorImageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
    }

    func setupNameCategoryConstraints() {
        nameActorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameActorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameActorLabel.topAnchor.constraint(equalTo: avatarActorImageView.bottomAnchor).isActive = true
        nameActorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
