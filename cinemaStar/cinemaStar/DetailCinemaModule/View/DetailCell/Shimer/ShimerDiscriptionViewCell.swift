// ShimerDiscriptionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер ячейка с описанием
final class ShimerDiscriptionViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let identefire = "shimerDiscriptionCell"
        static let gradientKey = "shimerCell"
    }

    // MARK: - Visual Components

    private lazy var discriptionLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var otherInfoLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let gradientBackground = CAGradientLayer()
    private let gradientTitle = CAGradientLayer()

    // MARK: - Public Properties

    let identefire = Constants.identefire

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradientBackground()
        setupGradientTitle()
    }

    // MARK: - Public Methods

    func makeCell() {
        makeUI()
    }

    // MARK: - Private Methods

    private func makeUI() {
        selectionStyle = .none
        contentView.addSubview(discriptionLabel)
        contentView.addSubview(otherInfoLabel)
        makeAhchor()
    }

    private func makeAhchor() {
        makeOtherLabelAnchor()
        makeDiscriptionLabelAnchor()
    }

    private func setupGradientBackground() {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = CGRect(
            x: discriptionLabel.center.x,
            y: discriptionLabel.center.y,
            width: contentView.frame.width - 50,
            height: contentView.frame.height - 40
        )
        gradientBackground.cornerRadius = 12
        discriptionLabel.layer.addSublayer(gradientBackground)
    }

    private func setupGradientTitle() {
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = CGRect(
            x: 0,
            y: 0,
            width: 160,
            height: 20
        )
        otherInfoLabel.layer.addSublayer(gradientTitle)
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

// MARK: - Layout

extension ShimerDiscriptionViewCell {
    private func makeOtherLabelAnchor() {
        otherInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        otherInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        otherInfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        otherInfoLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }

    private func makeDiscriptionLabelAnchor() {
        discriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8).isActive = true
        discriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        discriptionLabel.widthAnchor.constraint(equalToConstant: 330).isActive = true
        discriptionLabel.bottomAnchor.constraint(equalTo: otherInfoLabel.topAnchor).isActive = true
    }
}
