//
//  CatSaveUseCaseTests.swift
//  CatsTests
//

import Testing
@testable import Cats

@Suite("CatSaveUseCase")
struct CatSaveUseCaseTests {

    // MARK: - Helpers

    private func makeSUT(repository: MockCatsPersistenceRepository = MockCatsPersistenceRepository()) -> (CatSaveUseCase, MockCatsPersistenceRepository) {
        (CatSaveUseCase(catPersistenceRepository: repository), repository)
    }

    // MARK: - Save

    @Test("saveCat delegates to the persistence repository")
    func saveCatDelegatesToRepository() async throws {
        let (sut, repository) = makeSUT()
        let cat = Cat.fixture(id: "abc")

        try await sut.saveCat(cat)

        #expect(repository.saveCatCallCount == 1)
        #expect(repository.lastSavedCat?.id == "abc")
    }

    @Test("saveCat propagates error from repository")
    func saveCatPropagatesError() async {
        let (sut, repository) = makeSUT()
        repository.stubbedError = CatsError.persistence

        await #expect(throws: CatsError.persistence) {
            try await sut.saveCat(.fixture())
        }
    }

    // MARK: - Delete

    @Test("deleteCat delegates to the persistence repository")
    func deleteCatDelegatesToRepository() async throws {
        let (sut, repository) = makeSUT()
        let cat = Cat.fixture(id: "abc")

        try await sut.deleteCat(cat)

        #expect(repository.deleteCatCallCount == 1)
        #expect(repository.lastDeletedCat?.id == "abc")
    }

    @Test("deleteCat propagates error from repository")
    func deleteCatPropagatesError() async {
        let (sut, repository) = makeSUT()
        repository.stubbedError = CatsError.persistence

        await #expect(throws: CatsError.persistence) {
            try await sut.deleteCat(.fixture())
        }
    }

    // MARK: - isCatSaved

    @Test("isCatSaved returns true when repository reports cat is saved")
    func isCatSavedReturnsTrue() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedIsCatSaved = true

        let result = try await sut.isCatSaved(.fixture())

        #expect(result == true)
        #expect(repository.isCatSavedCallCount == 1)
    }

    @Test("isCatSaved returns false when repository reports cat is not saved")
    func isCatSavedReturnsFalse() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedIsCatSaved = false

        let result = try await sut.isCatSaved(.fixture())

        #expect(result == false)
    }

    @Test("isCatSaved forwards the correct cat to the repository")
    func isCatSavedForwardsCorrectCat() async throws {
        let (sut, repository) = makeSUT()
        let cat = Cat.fixture(id: "check-me")

        _ = try await sut.isCatSaved(cat)

        #expect(repository.lastCheckedCat?.id == "check-me")
    }

    @Test("isCatSaved propagates error from repository")
    func isCatSavedPropagatesError() async {
        let (sut, repository) = makeSUT()
        repository.stubbedError = CatsError.persistence

        await #expect(throws: CatsError.persistence) {
            try await sut.isCatSaved(.fixture())
        }
    }
}
