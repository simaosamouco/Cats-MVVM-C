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
    /// - Throws: An error if the network request fails.
    func fetchData(from url: URL) async throws -> Data
}

/// A concrete implementation of `NetworkServiceProtocol` using `URLSession`.
final class NetworkService: NetworkServiceProtocol {
    
    /// Fetches raw data from the specified URL asynchronously.
    func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw CatsErros.fecthingDataFailed
        }
    }
    
}
