// ActorsViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с актерами
final class ActorsViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let title = "Актеры и съемочная группа"
        static let languge = "Язык"
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

    private lazy var languageLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = .white
        title.textAlignment = .left
        title.text = Constants.languge
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

    let identefire = "actorsCell"

    // MARK: - Private Properties

    var actors: [Person]? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Public Methods

    func setupCell(person: [Person], language: String) {
        actors = person
        countryLabel.text = language
        makeUI()
    }

    // MARK: - Private Methods

    private func makeCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 46, height: contentView.frame.height)
        layout.scrollDirection = .horizontal
        collectionView.register(
            ActorCollectionViewCell.self,
            forCellWithReuseIdentifier: ActorCollectionViewCell().identefire
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

extension ActorsViewCell {
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

// MARK: - Extension + UICollectionViewDelegate, UICollectionViewDataSource

extension ActorsViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actors?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActorCollectionViewCell().identefire,
            for: indexPath
        ) as? ActorCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        if let person = actors?[indexPath.item] {
            cell.configure(dto: person)
        }
        return cell
    }
}
