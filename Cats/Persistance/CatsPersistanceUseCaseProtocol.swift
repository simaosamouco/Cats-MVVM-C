//
//  ItemUseCaseProtocol.swift
//  DogsTest
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
    
    private let repository: SwiftDataRepositoryProtocol
    
    init(repository: SwiftDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCats() async throws -> [Cat] {
        let swiftDataCats: [CatSwiftData] = try await repository.fetch()
        return swiftDataCats.compactMap { $0.toDomainModel() }
    }
    
    func saveCat(id: String, url: String, breedName: String, breedDescription: String) async throws {
        let cat = CatSwiftData(
            id: id,
            url: url,
            breedName: breedName,
            breedDescription: breedDescription
        )
        try await repository.insert(cat)
    }
    
    func deleteCat(id: String, url: String, breedName: String) async throws {
        let predicate = #Predicate<CatSwiftData> { cat in
            cat.id == id
        }
        try await repository.delete(predicate: predicate)
    }
    
    func isCatSaved(id: String) async throws -> Bool {
        let predicate = #Predicate<CatSwiftData> { cat in
            cat.id == id
        }
        return try await repository.exists(predicate: predicate)
    }
    
}
