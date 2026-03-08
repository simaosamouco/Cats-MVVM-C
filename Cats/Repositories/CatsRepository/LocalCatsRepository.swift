//
//  LocalCatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/03/2026.
//

protocol LocalCatsRepositoryProtocol: CatsRepositoryProtocol { }

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
