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
    ///   - key: The `LocalConfigKey` to associate the value with.
    func set<T: Codable>(_ value: T, for key: LocalConfigKey)
    
    /// Retrieves a value for a given local configuration key.
    ///
    /// - Parameters:
    ///   - key: The `LocalConfigKey` to retrieve the value for.
    ///   - type: The expected type of the value.
    /// - Returns: The stored value if it exists and can be decoded, otherwise `nil`.
    func get<T: Codable>(for key: LocalConfigKey, as type: T.Type) -> T?
    
    /// Removes a value for a given local configuration key.
    ///
    /// - Parameter key: The `LocalConfigKey` to remove.
    func remove(for key: LocalConfigKey)
    
    /// Checks if a value exists for a given local configuration key.
    ///
    /// - Parameter key: The `LocalConfigKey` to check.
    /// - Returns: `true` if a value exists, otherwise `false`.
    func exists(for key: LocalConfigKey) -> Bool
}
