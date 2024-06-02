// CinemaViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый вью контроллер
final class CinemaViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Смотри исторические\nфильмы на CINEMA STAR"
        static let topGradient = UIColor(named: "topGradient")?.cgColor
        static let bottomGradient = UIColor(named: "bottomGradient")?.cgColor
    }

    // MARK: - Visual Components

    private let titleView: UILabel = {
        let title = UILabel()
        title.text = Constants.title
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        let attributedString = NSMutableAttributedString(string: Constants.title)
        attributedString.addAttribute(
            .font,
            value: UIFont.boldSystemFont(ofSize: 20),
            range: (Constants.title as NSString).range(of: "CINEMA STAR")
        )
        title.attributedText = attributedString
        return title
    }()

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    // MARK: - Private Properties

    private var viewModel: MainViewModelProtocol?

    private var stateLoading: CinemaData = .initial {
        didSet {
            collectionView.reloadData()
        }
    }

    private var cinema: [CinemaDto] = []

    // MARK: - Initializers

    init(viewModel: MainViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.startFetch()
        setupFilms()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.addSubview(titleView)
        view.addSubview(collectionView)
        createGradient()
        setupCollectionView()
        setUpConstraint()
    }

    private func setupCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.width / 2.2, height: 250)
        collectionView.register(CinemaViewCell.self, forCellWithReuseIdentifier: CinemaViewCell().identefire)
        collectionView.register(
            ShimerCinemaCollectionViewCell.self,
            forCellWithReuseIdentifier: ShimerCinemaCollectionViewCell().identefire
        )
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setUpConstraint() {
        setupConstreintTitle()
        setupConstreintCollectionView()
    }

    private func setupFilms() {
        viewModel?.updateViewCinemaHandler = { [weak self] cinema in
            DispatchQueue.main.async {
                switch cinema {
                case let .success(films):
                    self?.cinema = films
                    self?.stateLoading = cinema
                case .failure:
                    self?.stateLoading = cinema
                case .initial:
                    self?.stateLoading = cinema
                case .loading:
                    self?.stateLoading = cinema
                }
            }
        }
    }
}

// MARK: - Extension + Layot

extension CinemaViewController {
    private func setupConstreintTitle() {
        titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func setupConstreintCollectionView() {
        collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDelegate, UICollectionViewDataSource

extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch stateLoading {
        case .initial, .loading, .failure:
            return
        case .success:
            viewModel?.pushDetail(id: cinema[indexPath.row].id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch stateLoading {
        case .initial, .loading, .failure:
            4
        case .success:
            cinema.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch stateLoading {
        case .initial, .loading:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShimerCinemaCollectionViewCell().identefire,
                for: indexPath
            ) as? ShimerCinemaCollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        case .success:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CinemaViewCell().identefire,
                for: indexPath
            ) as? CinemaViewCell else { return UICollectionViewCell() }
            let dto = cinema[indexPath.row]
            cell.configure(dto: dto)
            return cell
        case .failure:
            return UICollectionViewCell()
        }
    }
}
