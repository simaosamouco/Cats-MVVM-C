//
//  GetImageFromUrlUseCaseTests.swift
//  CatsTests
//

import Testing
import UIKit
@testable import Cats

@Suite("GetImageFromUrlUseCase")
struct GetImageFromUrlUseCaseTests {

    // MARK: - Helpers

    private func makeSUT(
        repository: MockImageRepository = MockImageRepository(),
        fallbackImage: UIImage = UIImage()
    ) -> (GetImageFromUrlUseCase, MockImageRepository) {
        (GetImageFromUrlUseCase(imageRepository: repository, fallbackImage: fallbackImage), repository)
    }

    // MARK: - Tests

    @Test("Returns the image provided by the repository on success")
    func returnsImageFromRepository() async {
        let (sut, repository) = makeSUT()
        let expected = UIImage()
        repository.stubbedImage = expected

        let result = await sut.get(from: "https://example.com/cat.jpg")

        #expect(result === expected)
    }

    @Test("Passes the URL string to the repository")
    func passesURLToRepository() async {
        let (sut, repository) = makeSUT()
        let url = "https://cdn.example.com/cats/123.jpg"

        _ = await sut.get(from: url)

        #expect(repository.lastRequestedURL == url)
        #expect(repository.getCallCount == 1)
    }

    @Test("Returns the fallback image when the repository throws")
    func returnsFallbackOnError() async {
        let fallback = UIImage()
        let (sut, repository) = makeSUT(fallbackImage: fallback)
        repository.stubbedError = CatsError.invalidImageData

        let result = await sut.get(from: "https://example.com/bad.jpg")

        #expect(result === fallback)
    }

    @Test("Never throws — always returns an image")
    func neverThrows() async {
        let (sut, repository) = makeSUT()
        repository.stubbedError = CatsError.fetchingDataFailed

        // The use case should absorb the error and return an image, not rethrow.
        let result = await sut.get(from: "https://example.com/bad.jpg")

        #expect(result != nil)
    }
}
