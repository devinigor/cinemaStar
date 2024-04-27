// DetailCinemaViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с детальной информацией о фильме
final class DetailCinemaViewController: UIViewController {
    // MARK: - SectionOnCell

    private enum SectionOnCell {
        /// ячейка с постером
        case poster
        /// ячейка с описанием
        case discription
        /// ячейка с актерами
        case actors
        /// ячейка с рекомендациями
        case recomendation
    }

    // MARK: - Constants

    private enum Constants {
        static let backButtonImageTitle = "chevron.backward"
    }

    // MARK: - Visual Components

    private lazy var detailTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(DetailCinemaTableViewCell.self, forCellReuseIdentifier: DetailCinemaTableViewCell().identefire)
        table.register(DiscriptionViewCell.self, forCellReuseIdentifier: DiscriptionViewCell().identefire)
        table.register(ActorsViewCell.self, forCellReuseIdentifier: ActorsViewCell().identefire)
        table.register(RecomendationViewCell.self, forCellReuseIdentifier: RecomendationViewCell().identefire)
        table.register(ShimerDetailViewCell.self, forCellReuseIdentifier: ShimerDetailViewCell().identefire)
        table.register(ShimerDiscriptionViewCell.self, forCellReuseIdentifier: ShimerDiscriptionViewCell().identefire)
        table.register(ShimerActorViewCell.self, forCellReuseIdentifier: ShimerActorViewCell().identefire)
        table.register(
            ShimerRecomendationCollectionViewCell.self,
            forCellReuseIdentifier: ShimerRecomendationCollectionViewCell().identefire
        )
        table.frame = view.frame
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.showsVerticalScrollIndicator = false
        return table
    }()

    // MARK: - Public Methods

    var detailViewModel: DetailViewModelProtocol

    // MARK: - Private Properties

    private var sectionCell: [SectionOnCell] = [.poster, .discription, .actors, .recomendation]

    private var stateLoading: DetailData = .initial {
        didSet {
            detailTableView.reloadData()
        }
    }

    private var isFavorites: Bool = false {
        didSet {
            favoritesButton(isFaforites: isFavorites)
        }
    }

    private var detailData: DetailsDto?

    private var openDicription = false

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUI()
        detailViewModel.fetchDetail()
        setupFilms()
        detailViewModel.checkFavorite()
        chekFavorites()
    }

    // MARK: - Initializers

    init(detailViewModel: DetailViewModelProtocol) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func makeNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: Constants.backButtonImageTitle),
            style: .done,
            target: self,
            action: #selector(dissmiss)
        )
        navigationItem.leftBarButtonItem = backButton
    }

    private func favoritesButton(isFaforites: Bool) {
        let likeButton = UIBarButtonItem(
            image: UIImage(systemName: isFaforites ? "heart.fill" : "heart"),
            style: .done,
            target: self,
            action: #selector(favoritesChangeCinema)
        )
        navigationItem.rightBarButtonItem = likeButton
    }

    private func makeUI() {
        view.addSubview(detailTableView)
        createGradient()
        makeNavigationBar()
    }

    private func chekFavorites() {
        detailViewModel.favoritesHandler = { [weak self] value in
            guard let self else { return }
            self.isFavorites = value
        }
    }

    private func setupFilms() {
        detailViewModel.updateViewDetailCinemaHadler = { [weak self] cinema in
            guard let self else { return }
            DispatchQueue.main.async {
                switch cinema {
                case let .success(films):
                    self.detailData = films
                    self.stateLoading = cinema
                    if films.similarMovies == nil {
                        self.sectionCell.removeLast()
                        self.detailTableView.reloadData()
                    }
                case .failure:
                    break
                case .initial:
                    break
                case .loading:
                    break
                }
            }
        }
    }

    private func callAlert() {
        callAlert(message: "Функционал в разработке :(")
    }

    private func openCell() {
        openDicription.toggle()
        detailTableView.reloadData()
    }

    @objc private func dissmiss() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func favoritesChangeCinema() {
        isFavorites.toggle()
        detailViewModel.saveFaforites()
    }
}

// MARK: - Extension + Delegate,DataSorse

extension DetailCinemaViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionCell.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sectionCell[indexPath.section]

        switch stateLoading {
        case .initial, .loading, .failure:
            switch section {
            case .poster:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimerDetailViewCell().identefire,
                    for: indexPath
                ) as? ShimerDetailViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.isUserInteractionEnabled = false
                cell.makeCell()
                return cell
            case .discription:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimerDiscriptionViewCell().identefire,
                    for: indexPath
                ) as? ShimerDiscriptionViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.isUserInteractionEnabled = false
                cell.makeCell()
                return cell
            case .actors:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimerActorViewCell().identefire,
                    for: indexPath
                ) as? ShimerActorViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.isUserInteractionEnabled = false
                cell.setupCell()
                return cell
            case .recomendation:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimerRecomendationCollectionViewCell().identefire,
                    for: indexPath
                ) as? ShimerRecomendationCollectionViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.isUserInteractionEnabled = false
                cell.setupCell()
                return cell
            }

        case .success:
            switch section {
            case .poster:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DetailCinemaTableViewCell().identefire,
                    for: indexPath
                ) as? DetailCinemaTableViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.makeCell(handler: callAlert, dto: detailData)
                return cell
            case .discription:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DiscriptionViewCell().identefire,
                    for: indexPath
                ) as? DiscriptionViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.makeCell(dto: detailData, selected: openCell)
                return cell
            case .actors:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ActorsViewCell().identefire,
                    for: indexPath
                ) as? ActorsViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.setupCell(person: detailData?.persons ?? [], language: detailData?.spokenLanguages ?? "")
                return cell
            case .recomendation:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecomendationViewCell().identefire,
                    for: indexPath
                ) as? RecomendationViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                cell.setupCell(person: detailData?.similarMovies ?? [])
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sectionCell[indexPath.section]

        switch section {
        case .poster:
            return 270
        case .discription:
            return !openDicription ? 100 : UITableView.automaticDimension
        case .actors:
            return 180
        case .recomendation:
            return 230
        }
    }
}
