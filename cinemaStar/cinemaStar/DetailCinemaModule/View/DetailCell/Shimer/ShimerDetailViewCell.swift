// ShimerDetailViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для деталей с постером
final class ShimerDetailViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let identefire = "shimerPosterCell"
        static let gradientKey = "shimerCell"
    }

    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.layer.cornerRadius = 8
        poster.clipsToBounds = true
        poster.sizeToFit()
        return poster
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var watchingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()

    private let gradientBackground = CAGradientLayer()
    private let gradientTitle = CAGradientLayer()
    private let gradientButton = CAGradientLayer()

    // MARK: - Public Properties

    let identefire = Constants.identefire

    // MARK: - Private Properties

    private var callAllert: VoidHandler?

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
        setupGradientBackground()
        setupGradientTitle()
        setupGradientButton()
    }

    // MARK: - Public Methods

    func makeCell() {
        makeUI()
        makeConstreint()
    }

    // MARK: - Private Properties

    private func makeUI() {
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(watchingButton)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }

    private func makeConstreint() {
        makeButtonConstrient()
        makePosterConstreint()
        makeTitlNameConstreint()
    }

    private func setupGradientBackground() {
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = contentView.bounds
        gradientBackground.cornerRadius = 12
        posterImageView.layer.addSublayer(gradientBackground)
    }

    private func setupGradientTitle() {
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = CGRect(x: titleLabel.center.x, y: titleLabel.center.y, width: 140, height: 70)
        gradientTitle.cornerRadius = 12
        titleLabel.layer.addSublayer(gradientTitle)
    }

    private func setupGradientButton() {
        gradientButton.startPoint = CGPoint(x: 0, y: 0.5)
        gradientButton.endPoint = CGPoint(x: 1, y: 0.5)
        gradientButton.frame = CGRect(
            x: watchingButton.center.x,
            y: watchingButton.center.y,
            width: contentView.frame.width - 40,
            height: 40
        )
        gradientButton.cornerRadius = 12
        watchingButton.layer.addSublayer(gradientButton)
    }

    private func addGradient() {
        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)
        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)
        let gradientButton = makeAnimation(previousGroup: viewBackgroundGroup)
        self.gradientButton.add(gradientButton, forKey: Constants.gradientKey)
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

extension ShimerDetailViewCell {
    private func makeButtonConstrient() {
        watchingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        watchingButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        watchingButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        watchingButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makePosterConstreint() {
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func makeTitlNameConstreint() {
        titleLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16)
            .isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}
