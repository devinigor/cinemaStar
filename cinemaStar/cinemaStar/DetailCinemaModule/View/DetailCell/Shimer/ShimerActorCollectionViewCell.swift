// ShimerActorCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер ячейка а актерами
final class ShimerActorCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 8
        static let identefire = "ShimerActorCellCollection"
        static let gradientKey = "shimerCell"
    }

    // MARK: - Public Properties

    let identefire = Constants.identefire

    // MARK: - Visual Components

    private lazy var avatarActorImageView: UIImageView = {
        let button = UIImageView()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameActorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gradientBackground = CAGradientLayer()
    private let gradientTitle = CAGradientLayer()

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

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradientBackground()
        setupGradientTitle()
    }

    // MARK: - Public Methods

    func configure() {
        addSubview()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(avatarActorImageView)
        contentView.addSubview(nameActorLabel)
    }

    private func setupGradientBackground() {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = avatarActorImageView.frame
        gradientBackground.cornerRadius = 12
        avatarActorImageView.layer.addSublayer(gradientBackground)
    }

    private func setupGradientTitle() {
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = CGRect(
            x: nameActorLabel.center.x,
            y: nameActorLabel.center.y,
            width: 40,
            height: 70
        )
        gradientBackground.cornerRadius = 12
        nameActorLabel.layer.addSublayer(gradientTitle)
    }

    private func addGradient() {
        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)

        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)
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

// MARK: - ShimerActorCollectionViewCell + Constraints

private extension ShimerActorCollectionViewCell {
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
