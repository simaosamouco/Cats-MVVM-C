//
//  Endpoints.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


import Foundation

enum Endpoints {
    
    case getCats(page: Int, limit: Int = 15, hasBreeds: Bool = true, order: String = "rand")
    
    private static let apiKey = "live_CFqvQ8IV7zHUZxSAUP6AzMcf8SfewdEGgWLqoI1OlyxfOY4j8i2SHBruM23sOgLU"

    func url() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        
        switch self {
        case .getCats(let page, let limit, let hasBreeds, let order):
            components.path = "/v1/images/search"
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "has_breeds", value: hasBreeds ? "1" : "0"),
                URLQueryItem(name: "order", value: order),
                URLQueryItem(name: "api_key", value: Endpoints.apiKey)
            ]
        }

        guard let url = components.url else {
            throw CatsErros.invalidURL
        }

        return url
    }
    
}
// https://api.thecatapi.com/v1/images/search?limit=10&page=0&has_breeds=1&order=rand&api_key=live_CFqvQ8IV7zHUZxSAUP6AzMcf8SfewdEGgWLqoI1OlyxfOY4j8i2SHBruM23sOgLU
