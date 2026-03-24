//
//  MockCatsPersistenceRepository.swift
//  CatsTests
//

import Foundation
@testable import Cats

final class MockCatsPersistenceRepository: CatsPersistenceRepositoryProtocol {

    var stubbedIsCatSaved = false
    var stubbedError: Error?

    var saveCatCallCount = 0
    var deleteCatCallCount = 0
    var isCatSavedCallCount = 0

    var lastSavedCat: Cat?
    var lastDeletedCat: Cat?
    var lastCheckedCat: Cat?

    func saveCat(_ cat: Cat) async throws {
        saveCatCallCount += 1
        lastSavedCat = cat
        if let error = stubbedError { throw error }
    }

    func deleteCat(_ cat: Cat) async throws {
        deleteCatCallCount += 1
        lastDeletedCat = cat
        if let error = stubbedError { throw error }
    }

    func isCatSaved(_ cat: Cat) async throws -> Bool {
        isCatSavedCallCount += 1
        lastCheckedCat = cat
        if let error = stubbedError { throw error }
        return stubbedIsCatSaved
    }
}
