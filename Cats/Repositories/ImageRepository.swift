//
//  ImageRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 24/11/2025.
//

import UIKit

protocol ImageRepositoryProtocol {
    func get(from imageURL: String) async throws -> UIImage
}

final class ImageRepository: ImageRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let imageCache: ImageCacheProtocol
    
    init(networkService: NetworkServiceProtocol,
         imageCache: ImageCacheProtocol) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
    
    func get(from imageURL: String) async throws -> UIImage {
        if let cachedImage = imageCache.retrieve(forKey: imageURL) {
            return cachedImage
        }
        
        guard let url = URL(string: imageURL) else {
            throw CatsErros.invalidURL
        }
        
        do {
            let imageData = try await networkService.fetchData(from: url)
            guard let image = UIImage(data: imageData) else {
                throw CatsErros.invalidImageData
            }
            imageCache.store(image, forKey: imageURL)
            return image
        } catch {
            throw CatsErros.fecthingDataFailed
        }
    }

    
}
