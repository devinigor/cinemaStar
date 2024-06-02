// DiscriptionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описание фильма
final class DiscriptionViewCell: UITableViewCell {
    // MARK: - Visual Components

    private lazy var discriptionLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = .white
        title.textAlignment = .left
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var otherInfoLabel: UILabel = {
        let title = UILabel()
        title.frame = contentView.frame
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = .black.withAlphaComponent(0.41)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var openDiscription: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        image.addTarget(self, action: #selector(openCell), for: .touchUpInside)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        return image
    }()

    // MARK: - Public Properties

    let identefire = "discriptionCell"
    var selectedCell: VoidHandler?

    // MARK: - Private Properties

    private var openDiscriptionCell = false

    // MARK: - Public Methods

    func makeCell(dto: DetailsDto?, selected: @escaping VoidHandler) {
        discriptionLabel.text = dto?.description
        if let dto = dto {
            otherInfoLabel.text = "\(dto.year)/ \(dto.countries)/ \(dto.type)"
        }
        makeUI()
        selectedCell = selected
    }

    // MARK: - Private Methods

    private func makeUI() {
        selectionStyle = .none
        contentView.addSubview(discriptionLabel)
        contentView.addSubview(otherInfoLabel)
        contentView.addSubview(openDiscription)
        makeAhchor()
    }

    private func makeAhchor() {
        makeOtherLabelAnchor()
        makeDiscriptionLabelAnchor()
        makeOpenButtonAnchor()
    }

    @objc private func openCell() {
        openDiscriptionCell.toggle()
        openDiscription.setImage(UIImage(systemName: openDiscriptionCell ? "chevron.down" : "chevron.up"), for: .normal)
        selectedCell?()
    }
}

// MARK: - Layout

extension DiscriptionViewCell {
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

    private func makeOpenButtonAnchor() {
        openDiscription.leadingAnchor.constraint(equalTo: discriptionLabel.trailingAnchor).isActive = true
        openDiscription.widthAnchor.constraint(equalToConstant: 24).isActive = true
        openDiscription.heightAnchor.constraint(equalToConstant: 24).isActive = true
        openDiscription.bottomAnchor.constraint(equalTo: discriptionLabel.bottomAnchor).isActive = true
    }
}
