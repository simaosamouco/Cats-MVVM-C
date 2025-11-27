//
//  InMemoryImageCache.swift
//  Cats
//
//  Created by Simão Neves Samouco on 24/11/2025.
//


//
//  InMemoryImageCache.swift
//  Cats
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
    
    init() {
        self.cache = NSCache<NSString, UIImage>()
    }
    
    func store(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
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
