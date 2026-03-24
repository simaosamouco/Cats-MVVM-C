//
//  MockGetImageFromUrlUseCase.swift
//  CatsTests
//

import UIKit
@testable import Cats

final class MockGetImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol {

    var stubbedImage: UIImage = UIImage()
    var getCallCount = 0
    var lastRequestedURL: String?

    func get(from imageURL: String) async -> UIImage {
        getCallCount += 1
        lastRequestedURL = imageURL
        return stubbedImage
    }
}
