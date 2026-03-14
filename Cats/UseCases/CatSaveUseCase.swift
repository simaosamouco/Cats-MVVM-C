//
//  CatSaveUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

protocol CatSaveUseCaseProtocol {
    func saveCat(_ cat: Cat) async throws
    func deleteCat(_ cat: Cat) async throws
    func isCatSaved(_ cat: Cat) async throws -> Bool
}

/// This use case delegates persistence, following the same structure as other use cases.
/// It enables future enhancements such as data transformation, validation, analytics, or side effects,
/// keeping the ViewModel decoupled from infrastructure.
final class CatSaveUseCase: CatSaveUseCaseProtocol {
    
    private let catPersistenceRepository: CatsPersistenceRepositoryProtocol
    
    init(catPersistenceRepository: CatsPersistenceRepositoryProtocol) {
        self.catPersistenceRepository = catPersistenceRepository
    }
    
    func saveCat(_ cat: Cat) async throws {
        try await catPersistenceRepository.saveCat(cat)
    }
    
    func deleteCat(_ cat: Cat) async throws {
        try await catPersistenceRepository.deleteCat(cat)
    }
    
    func isCatSaved(_ cat: Cat) async throws -> Bool {
        try await catPersistenceRepository.isCatSaved(cat)
    }
    
}
