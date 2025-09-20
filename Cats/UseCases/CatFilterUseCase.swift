//
//  CatFilterUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import Foundation

/// Protocol defining the contract for filtering a list of cats.
protocol CatFilterUseCaseProtocol {
    
    /// Filters an array of `CatCellViewModel` based on a search text.
    ///
    /// - Parameters:
    ///   - cats: The array of `CatCellViewModel` to filter.
    ///   - searchText: The text to filter the cats by.
    /// - Returns: A filtered array of `CatCellViewModel` whose `breedName` contains the search text (case-insensitive).
    func filter(cats: [CatCellViewModel], by searchText: String) -> [CatCellViewModel]
}

/// Concrete implementation of `CatFilterUseCaseProtocol`.
final class CatFilterUseCase: CatFilterUseCaseProtocol {

    func filter(cats: [CatCellViewModel], by searchText: String) -> [CatCellViewModel] {
        // If search text is empty, return all cats
        guard !searchText.isEmpty else { return cats }
        
        // Filter cats whose breed name contains the search text
        return cats.filter { $0.breedName.localizedCaseInsensitiveContains(searchText) }
    }
    
}
