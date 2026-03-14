//
//  CatDetailLocalManagementUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

protocol CatSaveUseCaseProtocol {
    func saveCat(_ cat: Cat) async throws
    func deleteCat(_ cat: Cat) async throws
    func isCatSaved(_ cat: Cat) async throws -> Bool
}

/// TODO: Add documentation explaing that this use case might look pointless
///  The goal is to follow the same patterns as other view model
///  And if in the future extra logic is required (like transform the object to a certain type) this use case would be useful
final class CatSaveUseCase: CatSaveUseCaseProtocol {
    
    private let catDetailRepository: CatsPersistenceRepositoryProtocol
    
    init(catDetailRepository: CatsPersistenceRepositoryProtocol) {
        self.catDetailRepository = catDetailRepository
    }
    
    func saveCat(_ cat: Cat) async throws {
        try await catDetailRepository.saveCat(cat)
    }
    
    func deleteCat(_ cat: Cat) async throws {
        try await catDetailRepository.deleteCat(cat)
    }
    
    func isCatSaved(_ cat: Cat) async throws -> Bool {
        try await catDetailRepository.isCatSaved(cat)
    }
    
}
