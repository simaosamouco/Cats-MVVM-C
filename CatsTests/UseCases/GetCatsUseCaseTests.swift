//
//  GetCatsUseCaseTests.swift
//  CatsTests
//

import Testing
@testable import Cats

@Suite("GetCatsUseCase")
struct GetCatsUseCaseTests {

    // MARK: - Helpers

    private func makeSUT(repository: MockCatsFetchRepository = MockCatsFetchRepository()) -> (GetCatsUseCase, MockCatsFetchRepository) {
        (GetCatsUseCase(repository: repository), repository)
    }

    // MARK: - Tests

    @Test("Returns cats for the given page")
    func returnsCatsForPage() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedCats = [.fixture(id: "1"), .fixture(id: "2")]

        let result = try await sut.get(for: 1)

        #expect(result.count == 2)
        #expect(result[0].id == "1")
        #expect(result[1].id == "2")
    }

    @Test("Passes the correct page number to the repository")
    func passesCorrectPage() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedCats = []

        _ = try await sut.get(for: 5)

        #expect(repository.lastRequestedPage == 5)
        #expect(repository.getCallCount == 1)
    }

    @Test("Default get() fetches page 1")
    func defaultGetFetchesPageOne() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedCats = []

        _ = try await sut.get()

        #expect(repository.lastRequestedPage == 1)
    }

    @Test("Returns empty array when repository returns no cats")
    func returnsEmptyArray() async throws {
        let (sut, repository) = makeSUT()
        repository.stubbedCats = []

        let result = try await sut.get(for: 1)

        #expect(result.isEmpty)
    }

    @Test("Propagates error thrown by repository")
    func propagatesRepositoryError() async {
        let (sut, repository) = makeSUT()
        repository.stubbedError = CatsError.fetchingDataFailed

        await #expect(throws: CatsError.fetchingDataFailed) {
            try await sut.get(for: 1)
        }
    }
}
