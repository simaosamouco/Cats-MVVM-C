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
    
    private let imageCache: NSCache<NSString, UIImage>
    private let networkService: NetworkServiceProtocol
    private let fallbackImage: UIImage
    
    init(networkService: NetworkServiceProtocol,
         imageCache: NSCache<NSString, UIImage> = NSCache(),
         fallbackImage: UIImage = UIImage.defaultErrorImage) {
        self.networkService = networkService
        self.imageCache = imageCache
        self.fallbackImage = fallbackImage
    }
    
    func get(from imageURL: String) async -> UIImage {
        // Validate URL
        guard let url = URL(string: imageURL) else {
            return fallbackImage
        }
        
        // Return cached image if available
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            return cachedImage
        }
        
        // Attempt to fetch image from network
        do {
            let imageData = try await networkService.fetchData(from: url)
            if let image = UIImage(data: imageData) {
                imageCache.setObject(image, forKey: NSString(string: imageURL))
                return image
            }
        } catch {
            return fallbackImage
        }
        
        // Return fallback if all else fails
        return fallbackImage
    }

}
