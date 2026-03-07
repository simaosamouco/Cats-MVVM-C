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

final class GetCatsUseCase: GetCatsUseCaseProtocol {
    
    private let repository: CatsRepositoryProtocol
    
    init(repository: CatsRepositoryProtocol) {
        self.repository = repository
    }
    
    func get(for page: Int) async throws -> [Cat] {
        try await repository.get(for: page)
    }
    
}
