//
//  UseCases/LocalConfigUseCase.swift
//  Cats
//
//  Created by Simão Neves Samouco on 29/08/2025.
//

import Foundation

/// Protocol defining the contract for storing, retrieving,
/// and managing local configuration values.
protocol LocalConfigUseCaseProtocol {
    
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

/// Concrete implementation of `LocalConfigUseCaseProtocol` using `UserDefaults`
/// for local storage. Handles storing and retrieving `Codable` types safely.
final class LocalConfigUseCase: LocalConfigUseCaseProtocol {
    
    private let userDefaults: UserDefaults
  
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// Stores a `Codable` value for a given key.
    ///
    /// Values are encoded as JSON data before storing.
    func set<T: Codable>(_ value: T, for key: LocalConfigKey) {
        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key.rawValue)
        }
    }
    
    /// Retrieves a `Codable` value for a given key.
    ///
    /// Values are decoded from JSON data.
    func get<T: Codable>(for key: LocalConfigKey, as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    /// Removes the value for a given key from `UserDefaults`.
    func remove(for key: LocalConfigKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    /// Checks if a value exists for a given key.
    func exists(for key: LocalConfigKey) -> Bool {
        userDefaults.object(forKey: key.rawValue) != nil
    }
    
}

