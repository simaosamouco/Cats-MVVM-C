//
//  CatDetailLocalManagementUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

protocol CatDetailLocalManagementUseCaseProtocol {
    func saveCat(_ cat: Cat) async throws
    func deleteCat(_ cat: Cat) async throws
    func isCatSaved(_ cat: Cat) async throws -> Bool
}

final class CatDetailLocalManagementUseCase: CatDetailLocalManagementUseCaseProtocol {
    
    private let catDetailRepository: CatDetailRepositoryProtocol
    
    init(catDetailRepository: CatDetailRepositoryProtocol) {
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
