// ApiResourse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

// favourite

protocol APIResource {
    associatedtype ModelType: Decodable
    associatedtype ModelTypeDetails: Decodable
    var methodPath: String { get }
    var methodPathDetail: String { get }
}

extension APIResource {
    var url: URLRequest? {
        let keychain = KeychainSwift()
//        keychain.set("PJQDAMA-R8WM875-NDEHYH4-WR4VM1G", forKey: "my key")
//        keychain.get("my key")
        let token = keychain.get("my key")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = methodPath
        components.queryItems = [URLQueryItem(name: "query", value: "история")]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "X-API-KEY")

        return request
    }

    var urlDetails: URLRequest? {
        let keychain = KeychainSwift()
        let token = keychain.get("my key")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = methodPathDetail
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "X-API-KEY")

        return request
    }
}

// Ресурс
struct Resource: APIResource {
    typealias ModelType = Cinema
    typealias ModelTypeDetails = DetailCinema
    var id: Int?

    var methodPath: String {
        "/v1.4/movie/search"
    }

    var methodPathDetail: String {
        "/v1.4/movie/\(id ?? 0)"
    }
}
