//
//  CatFilterUseCaseTests.swift
//  CatsTests
//

import Testing
@testable import Cats

@Suite("CatFilterUseCase")
struct CatFilterUseCaseTests {

    // MARK: - Helpers

    private let sut = CatFilterUseCase()

    private func makeCellViewModel(breedName: String) -> CatCellViewModel {
        CatCellViewModel(
            id: UUID().uuidString,
            url: "https://example.com/cat.jpg",
            breedName: breedName,
            getImageFromUrlUseCase: MockGetImageFromUrlUseCase()
        )
    }

    // MARK: - Tests

    @Test("Empty search text returns all cats unchanged")
    func emptySearchTextReturnsAll() {
        let cats = [makeCellViewModel(breedName: "Siamese"), makeCellViewModel(breedName: "Persian")]

        let result = sut.filter(cats: cats, by: "")

        #expect(result.count == 2)
    }

    @Test("Filters cats whose breed name contains the search text")
    func filtersMatchingBreedName() {
        let cats = [
            makeCellViewModel(breedName: "Siamese"),
            makeCellViewModel(breedName: "Persian"),
            makeCellViewModel(breedName: "Siberian")
        ]

        let result = sut.filter(cats: cats, by: "Si")

        #expect(result.count == 2)
        #expect(result.map(\.breedName).contains("Siamese"))
        #expect(result.map(\.breedName).contains("Siberian"))
    }

    @Test("Filter is case-insensitive")
    func filterIsCaseInsensitive() {
        let cats = [makeCellViewModel(breedName: "Siamese"), makeCellViewModel(breedName: "Persian")]

        let result = sut.filter(cats: cats, by: "siamese")

        #expect(result.count == 1)
        #expect(result.first?.breedName == "Siamese")
    }

    @Test("Returns empty when no cat matches the search text")
    func returnsEmptyWhenNoMatch() {
        let cats = [makeCellViewModel(breedName: "Siamese"), makeCellViewModel(breedName: "Persian")]

        let result = sut.filter(cats: cats, by: "xyz")

        #expect(result.isEmpty)
    }

    @Test("Filtering an empty list returns an empty list")
    func filteringEmptyListReturnsEmpty() {
        let result = sut.filter(cats: [], by: "Siamese")

        #expect(result.isEmpty)
    }

    @Test("Exact match returns only the matching cat")
    func exactMatchReturnsSingleResult() {
        let cats = [
            makeCellViewModel(breedName: "Persian"),
            makeCellViewModel(breedName: "Persian Blue"),
            makeCellViewModel(breedName: "Siamese")
        ]

        let result = sut.filter(cats: cats, by: "Siamese")

        #expect(result.count == 1)
        #expect(result.first?.breedName == "Siamese")
    }
}
