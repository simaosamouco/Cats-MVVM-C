//
//  Endpoints.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//

/// Provides API endpoint definitions and URL construction for The Cat API.

import Foundation

/// Enum representing API endpoints for The Cat API.
enum Endpoints {
    
    /// Retrieves a paginated list of cat images, optionally filtered by breed and order.
    /// - Parameters:
    ///   - page: The page number to fetch (zero-based).
    ///   - limit: The maximum number of results per page (default: 15).
    ///   - hasBreeds: If true, only results with breed information are included (default: true).
    ///   - order: The sort order for results, such as 'rand' for random (default: 'rand').
    case getCats(page: Int, limit: Int = 15, hasBreeds: Bool = true, order: String = "rand")
    
    /// The API key used for authenticating requests to The Cat API.
    private static let apiKey = "live_CFqvQ8IV7zHUZxSAUP6AzMcf8SfewdEGgWLqoI1OlyxfOY4j8i2SHBruM23sOgLU"

    /// Constructs the URL for the given endpoint case.
    /// - Returns: A fully formed URL for the endpoint.
    /// - Throws: `CatsErros.invalidURL` if the URL cannot be constructed.
    func url() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        
        // Configure URL components based on the endpoint case.
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
// Example endpoint: https://api.thecatapi.com/v1/images/search?limit=10&page=0&has_breeds=1&order=rand&api_key=live_CFqvQ8IV7zHUZxSAUP6AzMcf8SfewdEGgWLqoI1OlyxfOY4j8i2SHBruM23sOgLU
