//
//  Endpoints+URLRequest.swift
//  Cats
//
//  Created by Simão Neves Samouco on 15/03/2026.
//

import Foundation

// MARK: - Public

extension Endpoints {
    
    /// Constructs a `URLRequest` for the given endpoint, including the URL and authentication headers.
    /// - Returns: A fully configured `URLRequest` ready to be executed by the network layer.
    /// - Throws: `CatsError.invalidURL` if the URL cannot be constructed.
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: try makeURL())
        request.httpMethod = "GET"
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
    
}

// MARK: - Private

private extension Endpoints {
    
    /// HTTP headers to be attached to the request, including API key authentication.
    var headers: [String: String] {
        ["x-api-key": Secrets.catAPIKey]
    }
    
    /// The path component for the given endpoint case.
    var path: String {
        switch self {
        case .getCats: return "/v1/images/search"
        }
    }
    
    /// The query items for the given endpoint case.
    var queryItems: [URLQueryItem] {
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
    
    /// Constructs the URL for the given endpoint case.
    /// - Throws: `CatsError.invalidURL` if the URL cannot be constructed.
    func makeURL() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { throw CatsError.invalidURL }
        return url
    }
    
}
