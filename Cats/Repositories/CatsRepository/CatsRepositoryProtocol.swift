//
//  CatsRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/03/2026.
//


protocol CatsRepositoryProtocol {
    /// Fetches a page of cats from the underlying data source.
    ///
    /// - Parameter page: The 1-based page index to fetch.
    /// - Returns: An array of `Cat` models for the requested page.
    func get(for page: Int) async throws -> [Cat]
}