// ActorsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для коллекции с актерами
final class ActorCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 8
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    let identefire = "ActorCellCollection"

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
        label.font = UIFont(name: Constants.fontVerdana, size: Constants.valueCornerRadius)
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

    func configure(dto: Person) {
        DispatchQueue.global().async {
            self.avatarActorImageView.download(from: dto.photo)
        }
        nameActorLabel.text = dto.name
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(avatarActorImageView)
        contentView.addSubview(nameActorLabel)
    }
}

// MARK: - ActorCollectionViewCell + Constraints

private extension ActorCollectionViewCell {
    func setupConstraints() {
        setupCategoryButtonConstraints()
        setupNameCategoryConstraints()
    }

    func setupCategoryButtonConstraints() {
        avatarActorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        avatarActorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        avatarActorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        avatarActorImageView.heightAnchor.constraint(equalToConstant: 73).isActive = true
    }

    func setupNameCategoryConstraints() {
        nameActorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameActorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameActorLabel.topAnchor.constraint(equalTo: avatarActorImageView.bottomAnchor).isActive = true
        nameActorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
