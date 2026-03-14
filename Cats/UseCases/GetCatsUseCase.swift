//
//  GetCatsUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/03/2026.
//

import Foundation

protocol GetCatsUseCaseProtocol {
    func get(for page: Int) async throws -> [Cat]
}

extension GetCatsUseCaseProtocol {
    func get() async throws -> [Cat] {
        try await get(for: 1)
    }
}

final class GetCatsUseCase: GetCatsUseCaseProtocol {
    
    private let repository: CatsFetchRepositoryProtocol
    
    init(repository: CatsFetchRepositoryProtocol) {
        self.repository = repository
    }
    
    func get(for page: Int) async throws -> [Cat] {
        try await repository.get(for: page)
    }
    
}
