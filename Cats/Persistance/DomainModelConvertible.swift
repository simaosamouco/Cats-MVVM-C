//
//  DomainModelConvertible.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/09/2025.
//

import Foundation

/// A protocol that defines a type capable of converting itself into a domain model representation.
///
/// By conforming to this protocol, a persistence model provides a method to convert itself
/// into the corresponding domain model used in the business logic.
///
/// - Important: All new persistence models declared with `@Model` **must conform** to this protocol.
///              This ensures a consistent and explicit mapping between persistence models and domain models
///              (used in the business logic layer).
///
/// - Note: The conversion returns an optional value (`DomainModel?`) to account
///         for cases where the mapping may fail or the stored data is invalid.
protocol DomainModelConvertible {
    
    /// The type of the domain model that this persistence model can be converted into.
    associatedtype DomainModel
    
    /// Converts the current persistence model instance into its corresponding domain model.
    ///
    /// - Returns: A domain model instance if the conversion succeeds, or `nil`
    ///            if the conversion cannot be performed due to invalid or
    ///            missing data.
    func toDomainModel() -> DomainModel?
    
}
