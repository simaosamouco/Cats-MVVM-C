//
//  MockImageRepository.swift
//  CatsTests
//

import UIKit
@testable import Cats

final class MockImageRepository: ImageRepositoryProtocol {

    var stubbedImage: UIImage = UIImage()
    var stubbedError: Error?
    var getCallCount = 0
    var lastRequestedURL: String?

    func get(from imageURL: String) async throws -> UIImage {
        getCallCount += 1
        lastRequestedURL = imageURL
        if let error = stubbedError { throw error }
        return stubbedImage
    }
}
