//
//  InMemoryImageCache.swift
//  Cats
//
//  Created by Simão Neves Samouco on 24/11/2025.
//

import UIKit

protocol ImageCacheProtocol {
    /// Stores an image in the cache
    /// - Parameters:
    ///   - image: The image to cache
    ///   - key: The key to associate with the image
    func store(_ image: UIImage, forKey key: String)
    
    /// Retrieves an image from the cache
    /// - Parameter key: The key associated with the image
    /// - Returns: The cached image if available, nil otherwise
    func retrieve(forKey key: String) -> UIImage?
    
    /// Removes an image from the cache
    /// - Parameter key: The key associated with the image
    func remove(forKey key: String)
    
    /// Clears all cached images
    func clearAll()
}

final class ImageCache: ImageCacheProtocol {
    
    private let cache: NSCache<NSString, UIImage>
    /// This represents the max cost to cache
    /// After the amount of MB set in this var is reached the cache will release older entries
    private let totalCostLimit = 500 * 1024 * 1024 // 500MB
    
    init() {
        self.cache = NSCache<NSString, UIImage>()
        self.cache.totalCostLimit = totalCostLimit
    }
    
    func store(_ image: UIImage, forKey key: String) {
        cache.setObject(
            image,
            forKey: NSString(string: key),
            cost: image.estimatedByteSize
        )
    }
    
    func retrieve(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func remove(forKey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
    
    func clearAll() {
        cache.removeAllObjects()
    }
    
}
