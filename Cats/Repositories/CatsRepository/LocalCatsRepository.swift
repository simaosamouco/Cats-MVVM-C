//
//  LocalCatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/03/2026.
//

/// This protocol intentionally adds no new requirements. Its purpose is to allow
/// the dependency injection container to distinguish between multiple concrete
/// implementations of `CatsRepositoryProtocol`
protocol LocalCatsRepositoryProtocol: CatsRepositoryProtocol { }

/// A concrete implementation of `LocalCatsRepositoryProtocol` that fetches cats
/// from local persistence via a `PersistenceStoreProtocol`.
final class LocalCatsRepository: LocalCatsRepositoryProtocol {
    
    private let store: PersistenceStoreProtocol
    
    init(store: PersistenceStoreProtocol) {
        self.store = store
    }
    
    func get(for page: Int) async throws -> [Cat] {
        let swiftDataCats: [CatSwiftData] = try await store.fetch()
        return swiftDataCats.compactMap { $0.toDomainModel() }
    }
    
}
