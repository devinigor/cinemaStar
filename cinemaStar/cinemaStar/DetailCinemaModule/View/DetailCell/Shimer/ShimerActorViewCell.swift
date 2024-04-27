// ShimerActorViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер ячейка с актерами
final class ShimerActorViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let identefire = "ShimerActorCell"
    }

    // MARK: - Visual Components

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    private let actorTitle: UILabel = {
        let text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private lazy var languageLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = .white
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var countryLabel: UILabel = {
        let title = UILabel()
        title.frame = contentView.frame
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = .black.withAlphaComponent(0.41)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    // MARK: - Public Properties

    let identefire = Constants.identefire

    // MARK: - Public Methods

    func setupCell() {
        makeUI()
    }

    // MARK: - Private Methods

    private func makeCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: 46, height: contentView.frame.height)
        layout.scrollDirection = .horizontal
        collectionView.register(
            ShimerActorCollectionViewCell.self,
            forCellWithReuseIdentifier: ShimerActorCollectionViewCell().identefire
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.frame = contentView.frame
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
    }

    private func makeUI() {
        selectionStyle = .none
        makeCollectionView()
        contentView.addSubview(collectionView)
        contentView.addSubview(actorTitle)
        contentView.addSubview(languageLabel)
        contentView.addSubview(countryLabel)
        makeAnchor()
    }

    private func makeAnchor() {
        makeTitleAnchor()
        makeOtherLabelAnchor()
        makeTitleLanguageAnchor()
    }
}

// MARK: Layout

extension ShimerActorViewCell {
    private func makeTitleAnchor() {
        actorTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        actorTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        actorTitle.widthAnchor.constraint(equalToConstant: 202).isActive = true
        actorTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeTitleLanguageAnchor() {
        languageLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: 7).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        languageLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeOtherLabelAnchor() {
        countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        countryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension ShimerActorViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShimerActorCollectionViewCell().identefire,
            for: indexPath
        ) as? ShimerActorCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        cell.configure()
        return cell
    }
}
