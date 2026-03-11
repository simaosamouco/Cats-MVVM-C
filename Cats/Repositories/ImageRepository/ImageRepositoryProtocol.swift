//
//  ImageRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/03/2026.
//

import UIKit

protocol ImageRepositoryProtocol {
    /// Fetches an image from the given URL string, returning a cached version if available.
    ///
    /// - Parameter imageURL: The URL string of the image to fetch.
    func get(from imageURL: String) async throws -> UIImage
}
