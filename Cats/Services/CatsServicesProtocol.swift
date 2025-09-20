//
//  RocketsServicesProtocol.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


import Foundation

/// A protocol defining the interface for fetching cat data from a remote source.
protocol CatsServicesProtocol {
    
    /// Fetches a list of cats from the API for the specified page.
    ///
    /// - Parameter page: The page number to fetch.
    /// - Returns: An array of `Cat` objects retrieved from the API.
    /// - Throws: An error if the network request fails or the data cannot be decoded.
    func getCats(page: Int) async throws -> [Cat]
}

/// A concrete implementation of `CatsServicesProtocol` using a network service.
final class CatsServices: CatsServicesProtocol {
    
    /// The network service used for fetching data.
    let networkService: NetworkServiceProtocol
    
    private let decoder = JSONDecoder()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Fetches a list of cats for a given page asynchronously.
    func getCats(page: Int) async throws -> [Cat] {
        let catsData = try await fetchData(from: Endpoints.getCats(page: page).url())
        return try decode([Cat].self, from: catsData)
    }
    
    /// Fetches raw data from the given URL using the injected network service.
    private func fetchData(from url: URL) async throws -> Data {
        return try await networkService.fetchData(from: url)
    }
    
    /// Decodes JSON data into a specified `Decodable` type.
    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CatsErros.decodingFailed
        }
    }
    
}
