// RecomendationViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рекомендацией
final class RecomendationViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let title = "Смотрите также"
    }

    // MARK: - Visual Components

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    private let actorTitle: UILabel = {
        let text = UILabel()
        text.text = Constants.title
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    // MARK: - Public Properties

    let identefire = "recomendation"

    // MARK: - Private Properties

    var filmsRecomendation: [SimilarMovie]? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Public Methods

    func setupCell(person: [SimilarMovie]) {
        filmsRecomendation = person
        makeUI()
    }

    // MARK: - Private Methods

    private func makeCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 170, height: contentView.frame.height)
        layout.scrollDirection = .horizontal
        collectionView.register(
            RecomendationCollectionViewCell.self,
            forCellWithReuseIdentifier: RecomendationCollectionViewCell().identefire
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = contentView.frame
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func makeUI() {
        selectionStyle = .none
        makeCollectionView()
        contentView.addSubview(collectionView)
        contentView.addSubview(actorTitle)
        makeAnchor()
    }

    private func makeAnchor() {
        makeTitleAnchor()
    }
}

// MARK: Layout

extension RecomendationViewCell {
    private func makeTitleAnchor() {
        actorTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        actorTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        actorTitle.widthAnchor.constraint(equalToConstant: 202).isActive = true
        actorTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDelegate, UICollectionViewDataSource

extension RecomendationViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filmsRecomendation?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecomendationCollectionViewCell().identefire,
            for: indexPath
        ) as? RecomendationCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        if let film = filmsRecomendation?[indexPath.item] {
            cell.configure(dto: film)
        }
        return cell
    }
}
