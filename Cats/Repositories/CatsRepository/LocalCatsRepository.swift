//
//  LocalCatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/03/2026.
//

import Foundation

/// A concrete implementation of `LocalCatsRepositoryProtocol` that fetches, saves, deletes
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
    
    func saveCat(_ cat: Cat) async throws {
        // Map domain model to SwiftData model before inserting into the store
        let cat = CatSwiftData(
            id: cat.id,
            url: cat.url,
            breedName: cat.breedName,
            breedDescription: cat.breedDescription
        )
        try await store.insert(cat)
    }
    
    func deleteCat(_ cat: Cat) async throws {
        let id = cat.id
        let predicate = #Predicate<CatSwiftData> { $0.id == id }
        try await store.delete(predicate: predicate)
    }

    func isCatSaved(_ cat: Cat) async throws -> Bool {
        let id = cat.id
        let predicate = #Predicate<CatSwiftData> { $0.id == id }
        return try await store.exists(predicate: predicate)
    }
    
}
