//
//  RemoteCatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/03/2026.
//

/// This protocol intentionally adds no new requirements. Its purpose is to allow
/// the dependency injection container to distinguish between multiple concrete
/// implementations of `CatsRepositoryProtocol`
protocol RemoteCatsRepositoryProtocol: CatsFetchRepositoryProtocol { }

/// A concrete implementation of `LocalCatsRepositoryProtocol` that fetches cats
/// from the API via a `CatsServicesProtocol`.
final class RemoteCatsRepository: RemoteCatsRepositoryProtocol {
    
    private let catsService: CatsServicesProtocol
    
    init(catsService: CatsServicesProtocol) {
        self.catsService = catsService
    }
    
    func get(for page: Int) async throws -> [Cat] {
        try await catsService.getCats(page: page)
    }
    
}
