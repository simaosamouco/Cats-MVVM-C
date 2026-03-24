//
//  MockCatsFetchRepository.swift
//  CatsTests
//

import Foundation
@testable import Cats

final class MockCatsFetchRepository: CatsFetchRepositoryProtocol {

    var stubbedCats: [Cat] = []
    var stubbedError: Error?
    var getCallCount = 0
    var lastRequestedPage: Int?

    func get(for page: Int) async throws -> [Cat] {
        getCallCount += 1
        lastRequestedPage = page
        if let error = stubbedError { throw error }
        return stubbedCats
    }
}
