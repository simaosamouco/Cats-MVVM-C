//
//  Endpoints.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//

/// Provides API endpoint definitions and URL construction for The Cat API.

import Foundation

/// Defines the sort order for cat image results.
enum Order: String {
    case random = "rand"
    case ascending = "asc"
    case descending = "desc"
}

/// Enum representing API endpoints for The Cat API.
enum Endpoints {
    
    /// Retrieves a paginated list of cat images, optionally filtered by breed and order.
    /// - Parameters:
    ///   - page: The page number to fetch (zero-based).
    ///   - limit: The maximum number of results per page (default: 15).
    ///   - hasBreeds: If true, only results with breed information are included (default: true).
    ///   - order: The sort order for results, .random being the default.
    case getCats(page: Int,
                 limit: Int = 15,
                 hasBreeds: Bool = true,
                 order: Order = .random)
    
    
    
}
