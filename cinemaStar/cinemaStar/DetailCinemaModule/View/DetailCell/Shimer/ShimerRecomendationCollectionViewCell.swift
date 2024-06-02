// ShimerRecomendationCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Шимер для ячейки с реклмендациями
final class ShimerRecomendationCollectionViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let gradientKey = "shimerCell"
        static let identefire = "ShimerRecomendation"
    }

    // MARK: - Visual Components

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    private let actorTitle: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let gradientBackground = CAGradientLayer()

    // MARK: - Public Properties

    let identefire = Constants.identefire

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradientBackground()
    }

    // MARK: - Public Methods

    func setupCell() {
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

    private func setupGradientBackground() {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        gradientBackground.cornerRadius = 12
        actorTitle.layer.addSublayer(gradientBackground)
    }

    private func addGradient() {
        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)
        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
    }

    private func makeAnimation(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5

        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation.fromValue = UIColor.lightGray.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = animDuration
        animation.beginTime = 0.0

        let secondAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        secondAnimation.fromValue = UIColor.white.cgColor
        secondAnimation.toValue = UIColor.lightGray.cgColor
        secondAnimation.duration = animDuration
        secondAnimation.beginTime = animation.beginTime + secondAnimation.duration

        let group = CAAnimationGroup()
        group.animations = [animation, secondAnimation]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = secondAnimation.beginTime + animation.duration
        group.isRemovedOnCompletion = false

        return group
    }
}

// MARK: Layout

extension ShimerRecomendationCollectionViewCell {
    private func makeTitleAnchor() {
        actorTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        actorTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        actorTitle.widthAnchor.constraint(equalToConstant: 202).isActive = true
        actorTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDelegate, UICollectionViewDataSource

extension ShimerRecomendationCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
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

        // cell.configure(dto: film)

        return cell
    }
}
