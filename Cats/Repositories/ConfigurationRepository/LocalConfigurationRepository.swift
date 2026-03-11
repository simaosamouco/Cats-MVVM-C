//
//  LocalConfigurationRepository.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/03/2026.
//

import Foundation

protocol LocalConfigurationRepositoryProtocol: ConfigurationRepositoryProtocol { }

/// Concrete implementation of `ConfigurationRepositoryProtocol` using `UserDefaults`
/// for local storage. Handles storing and retrieving `Codable` types safely.
final class LocalConfigurationRepository: LocalConfigurationRepositoryProtocol {
    
    private let userDefaults: UserDefaults
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()
  
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// Stores a `Codable` value for a given key.
    ///
    /// Values are encoded as JSON data before storing.
    func set<T: Codable>(_ value: T, for key: LocalConfigKey) {
        if let data = try? encoder.encode(value) {
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
        return try? decoder.decode(T.self, from: data)
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
