//
//  ImageRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 24/11/2025.
//

import UIKit

/// A concrete implementation of `ImageRepositoryProtocol` that fetches images over
/// the network and caches them locally to avoid redundant requests.
final class ImageRepository: ImageRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let imageCache: ImageCacheProtocol
    
    init(networkService: NetworkServiceProtocol,
         imageCache: ImageCacheProtocol) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
    
    /// This method first checks the local cache for an existing entry.
    /// On a cache miss, it performs a network request, decodes the response into a `UIImage`,
    /// stores the result in the cache, and returns it.
    func get(from imageURL: String) async throws -> UIImage {
        if let cachedImage = imageCache.retrieve(forKey: imageURL) {
            return cachedImage
        }
        
        guard let url = URL(string: imageURL) else {
            throw CatsError.invalidURL
        }
        
        do {
            let imageData = try await networkService.fetchData(from: url)
            guard let image = UIImage(data: imageData) else {
                throw CatsError.invalidImageData
            }
            imageCache.store(image, forKey: imageURL)
            return image
        } catch {
            throw CatsError.fetchingDataFailed
        }
    }

}
