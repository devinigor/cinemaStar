// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол комуникации с networkService
protocol NetworkServiceProtocol: AnyObject {
    /// запрос для получения фильмов
    func getFilm(withCompletion completion: @escaping ([CinemaDto]?) -> Void)
    /// Запрос на детали фильма
    func getDetail(id: Int, withCompletion completion: @escaping (DetailsDto?) -> Void)
    /// Запрос картинки
    func execute(url: URL?, withCompletion completion: @escaping (Data?) -> Void)
}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    associatedtype ModelTypeDetails
    func decode(_ data: Data) -> [CinemaDto]?
    func decodeDetails(_ data: Data) -> ModelTypeDetails?
}

final class NetworkService: NetworkRequest, NetworkServiceProtocol {
    typealias ModelType = CinemaDto
    typealias ModelTypeDetails = DetailsDto
    let resource = Resource()

    func decode(_ data: Data) -> [CinemaDto]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Cinema.self, from: data)
        let result = wrapper?.docs.map { CinemaDto(dto: $0) }
        return result
    }

    func decodeDetails(_ data: Data) -> ModelTypeDetails? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(DetailCinema.self, from: data)
        guard let wrapper else { return nil }
        let result = DetailsDto(dto: wrapper)
        return result
    }

    func getFilm(withCompletion completion: @escaping ([CinemaDto]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }

    func getDetail(id: Int, withCompletion completion: @escaping (ModelTypeDetails?) -> Void) {
        let request = Resource(id: id)
        loadDetails(request.urlDetails, withCompletion: completion)
    }

    func execute(url: URL?, withCompletion completion: @escaping (Data?) -> Void) {
        loadImage(url, withCompletion: completion)
    }
}

private extension NetworkRequest {
    func load(_ url: URLRequest?, withCompletion completion: @escaping ([CinemaDto]?) -> Void) {
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }

    func loadDetails(_ url: URLRequest?, withCompletion completion: @escaping (ModelTypeDetails?) -> Void) {
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decodeDetails(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }

    func loadImage(_ url: URL?, withCompletion completion: @escaping (Data) -> Void) {
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async { completion(Data()) }
                return
            }
            DispatchQueue.main.async { completion(data) }
        }
        task.resume()
    }
}
