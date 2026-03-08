//
//  ItemUseCaseProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

import SwiftData
import Foundation

protocol CatsPersistanceUseCaseProtocol {
    func fetchCats() async throws -> [Cat]
    func saveCat(id: String, url: String, breedName: String, breedDescription: String) async throws
    func deleteCat(id: String, url: String, breedName: String) async throws
    func isCatSaved(id: String) async throws -> Bool
}

final class CatsPersistanceUseCase: CatsPersistanceUseCaseProtocol {
    
    private let store: PersistenceStoreProtocol
    
    init(store: PersistenceStoreProtocol) {
        self.store = store
    }
    
    func fetchCats() async throws -> [Cat] {
        let swiftDataCats: [CatSwiftData] = try await store.fetch()
        return swiftDataCats.compactMap { $0.toDomainModel() }
    }
    
    func saveCat(id: String,
                 url: String,
                 breedName: String,
                 breedDescription: String) async throws {
        let cat = CatSwiftData(
            id: id,
            url: url,
            breedName: breedName,
            breedDescription: breedDescription
        )
        try await store.insert(cat)
    }
    
    func deleteCat(id: String,
                   url: String,
                   breedName: String) async throws {
        let predicate = #Predicate<CatSwiftData> { cat in
            cat.id == id
        }
        try await store.delete(predicate: predicate)
    }
    
    func isCatSaved(id: String) async throws -> Bool {
        let predicate = #Predicate<CatSwiftData> { cat in
            cat.id == id
        }
        return try await store.exists(predicate: predicate)
    }
    
}
