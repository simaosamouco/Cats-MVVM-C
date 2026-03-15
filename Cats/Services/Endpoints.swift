//
//  Endpoints.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//

/// Provides API endpoint definitions and URL construction for The Cat API.

import Foundation

/// Defines the sort order for cat image results.
enum Order: String {
    case random = "rand"
    case ascending = "asc"
    case descending = "desc"
}

/// Enum representing API endpoints for The Cat API.
enum Endpoints {
    
    /// Retrieves a paginated list of cat images, optionally filtered by breed and order.
    /// - Parameters:
    ///   - page: The page number to fetch (zero-based).
    ///   - limit: The maximum number of results per page (default: 15).
    ///   - hasBreeds: If true, only results with breed information are included (default: true).
    ///   - order: The sort order for results, .random being the default.
    case getCats(page: Int,
                 limit: Int = 15,
                 hasBreeds: Bool = true,
                 order: Order = .random)
    
    /// Constructs a `URLRequest` for the given endpoint, including the URL and authentication headers.
    /// - Returns: A fully configured `URLRequest` ready to be executed by the network layer.
    /// - Throws: `CatsError.invalidURL` if the URL cannot be constructed.
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: try makeURL())
        request.httpMethod = "GET"
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
    
    /// Constructs the URL for the given endpoint case.
    /// - Throws: `CatsError.invalidURL` if the URL cannot be constructed.
    private func makeURL() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { throw CatsError.invalidURL }
        return url
    }
    
    /// The path component for the given endpoint case.
    private var path: String {
        switch self {
        case .getCats: return "/v1/images/search"
        }
    }
    
    /// The query items for the given endpoint case.
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getCats(let page, let limit, let hasBreeds, let order):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "has_breeds", value: hasBreeds ? "1" : "0"),
                URLQueryItem(name: "order", value: order.rawValue)
            ]
        }
    }
    
    /// HTTP headers to be attached to the request, including API key authentication.
    private var headers: [String: String] {
        ["x-api-key": Secrets.catAPIKey]
    }
    
}
// Example endpoint: https://api.thecatapi.com/v1/images/search?limit=10&page=0&has_breeds=1&order=rand&api_key=apiKey
