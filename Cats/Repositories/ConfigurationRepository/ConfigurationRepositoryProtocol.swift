//
//  ConfigurationRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/03/2026.
//

import Foundation

/// Protocol defining the contract for storing, retrieving,
/// and managing configuration values.
protocol ConfigurationRepositoryProtocol {
    
    /// Stores a value for a given local configuration key.
    ///
    /// - Parameters:
    ///   - value: The value to store. Must conform to `Codable`.
    ///   - key: The `ConfigurationKey` to associate the value with.
    func set<T: Codable>(_ value: T, for key: ConfigurationKey)
    
    /// Retrieves a value for a given local configuration key.
    ///
    /// - Parameters:
    ///   - key: The `ConfigurationKey` to retrieve the value for.
    ///   - type: The expected type of the value.
    /// - Returns: The stored value if it exists and can be decoded, otherwise `nil`.
    func get<T: Codable>(for key: ConfigurationKey, as type: T.Type) -> T?
    
    /// Removes a value for a given local configuration key.
    ///
    /// - Parameter key: The `ConfigurationKey` to remove.
    func remove(for key: ConfigurationKey)
    
    /// Checks if a value exists for a given local configuration key.
    ///
    /// - Parameter key: The `ConfigurationKey` to check.
    /// - Returns: `true` if a value exists, otherwise `false`.
    func exists(for key: ConfigurationKey) -> Bool
}
