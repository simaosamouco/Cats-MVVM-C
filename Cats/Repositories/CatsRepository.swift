//
//  CatsRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/03/2026.
//

import Foundation

protocol CatsRepositoryProtocol {
    func get(for page: Int) async throws -> [Cat]
}

final class CatsRepository: CatsRepositoryProtocol {
    
    private var catsService: CatsServicesProtocol
    
    init(catsService: CatsServicesProtocol) {
        self.catsService = catsService
    }
    
    func get(for page: Int) async throws -> [Cat] {
        try await catsService.getCats(page: page)
    }
    
}
