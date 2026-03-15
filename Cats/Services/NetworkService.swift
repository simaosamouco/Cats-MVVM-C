//
//  NetworkServiceProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


import Foundation

/// A protocol defining the interface for network data fetching.
protocol NetworkServiceProtocol {

    /// Fetches raw data from the specified URL asynchronously.
    ///
    /// - Parameter url: The URL to fetch data from.
    /// - Returns: The data retrieved from the network request.
    /// - Throws: `CatsError.fetchingDataFailed` if the network request fails.
    func fetchData(from url: URL) async throws -> Data

    /// Fetches raw data from the specified URL request asynchronously.
    ///
    /// - Parameter request: The URLRequest to fetch data from.
    /// - Returns: The data retrieved from the network request.
    /// - Throws: `CatsError.fetchingDataFailed` if the network request fails.
    func fetchData(from request: URLRequest) async throws -> Data
}

/// A concrete implementation of `NetworkServiceProtocol` using `URLSession`.
final class NetworkService: NetworkServiceProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetches raw data from the specified URL asynchronously.
    /// Wraps the URL in a `URLRequest` and delegates to `fetchData(from:URLRequest)`.
    func fetchData(from url: URL) async throws -> Data {
        try await fetchData(from: URLRequest(url: url))
    }

    /// Fetches raw data from the specified URL request asynchronously.
    func fetchData(from request: URLRequest) async throws -> Data {
        do {
            let (data, _) = try await session.data(for: request)
            return data
        } catch {
            throw CatsError.fetchingDataFailed
        }
    }

}
