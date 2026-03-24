//
//  MockConfigurationRepository.swift
//  CatsTests
//

import Foundation
@testable import Cats

final class MockConfigurationRepository: ConfigurationRepositoryProtocol {

    private var storage: [String: Any] = [:]

    var setCallCount = 0
    var getCallCount = 0
    var removeCallCount = 0
    var existsCallCount = 0

    func set<T: Codable>(_ value: T, for key: ConfigurationKey) {
        setCallCount += 1
        storage[key.rawValue] = value
    }

    func get<T: Codable>(for key: ConfigurationKey, as type: T.Type) -> T? {
        getCallCount += 1
        return storage[key.rawValue] as? T
    }

    func remove(for key: ConfigurationKey) {
        removeCallCount += 1
        storage.removeValue(forKey: key.rawValue)
    }

    func exists(for key: ConfigurationKey) -> Bool {
        existsCallCount += 1
        return storage[key.rawValue] != nil
    }
}
