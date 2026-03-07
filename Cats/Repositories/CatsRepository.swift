//
//  CatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/03/2026.
//

import Foundation

protocol CatsRepositoryProtocol {
    /// Fetches a page of cats from the underlying data source.
    ///
    /// - Parameter page: The 1-based page index to fetch.
    /// - Returns: An array of `Cat` models for the requested page.
    func get(for page: Int) async throws -> [Cat]
}

/// A concrete implementation of `CatsRepositoryProtocol` that fetches cat data
/// from the remote `CatsServicesProtocol`.
///
/// - Note: In its current form this class is intentionally thin — it delegates
///   directly to `catsService` with no additional logic. This is not redundancy
///   but rather a deliberate architectural boundary. Should a second data source
///   be introduced (e.g. local persistence, an in-memory cache, or a mock for
///   testing), the fan-out logic lives here and no other file needs to change.
final class CatsRepository: CatsRepositoryProtocol {
    
    private var catsService: CatsServicesProtocol
    
    init(catsService: CatsServicesProtocol) {
        self.catsService = catsService
    }
    
    func get(for page: Int) async throws -> [Cat] {
        try await catsService.getCats(page: page)
    }
    
}
