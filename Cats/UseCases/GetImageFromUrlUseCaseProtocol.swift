//
//  GetImageFromUrlUseCaseProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


import UIKit

/// A use case responsible for fetching an image from a URL, caching it,
/// and providing a fallback image if the fetch fails.
protocol GetImageFromUrlUseCaseProtocol {
    /// Fetches an image from the specified URL string.
    ///
    /// - Parameter imageURL: The URL string of the image to fetch.
    /// - Returns: A `UIImage` from the cache, network, or the fallback image if fetching fails.
    ///
    /// This method validates the URL String, returns fallback image if it fails.
    /// Checks Cache for an extisting image, returns it if available.
    /// Download the image from the URL, converts the `Data` into an `UIImage` and caches it.
    /// Returns the downloaded image, or the fallback image if the download fails.
    func get(from imageURL: String) async -> UIImage
}

final class GetImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol {
    
    private let imageRepository: ImageRepositoryProtocol
    private let fallbackImage: UIImage
    
    init(imageRepository: ImageRepositoryProtocol,
         fallbackImage: UIImage = UIImage.defaultErrorImage) {
        self.imageRepository = imageRepository
        self.fallbackImage = fallbackImage
    }
    
    func get(from imageURL: String) async -> UIImage {
        do {
            return try await imageRepository.get(from: imageURL)
        } catch {
            return fallbackImage
        }
    }

}
