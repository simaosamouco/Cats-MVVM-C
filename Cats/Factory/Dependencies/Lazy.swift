//
//  Lazy.swift
//  Cats
//
//  Created by Simão Neves Samouco on 10/09/2025.
//

import Foundation

/// A wrapper that ensures lazy initialization of instances.
/// The instance is created only once, on first access, and then cached.
/// Thread-safe: concurrent access is handled via double-checked locking.
final class Lazy<T> {

    private let factory: () -> T            // Stores HOW to create the instance
    private var _instance: T?               // Stores the actual instance, nil until first access
    private let lock = NSLock()             // Ensures only one thread initializes the instance

    /// Creates a new lazy wrapper with the provided factory closure.
    /// - Parameter factory: A closure that creates the instance when needed
    init(factory: @escaping () -> T) {
        self.factory = factory              // Save the creation closure
    }

    /// Gets the instance, creating it lazily on first access.
    /// Subsequent accesses return the cached instance.
    /// Uses double-checked locking: checks once before acquiring the lock (fast path),
    /// and once again inside the lock to handle concurrent first-access scenarios.
    var instance: T {
        if let existing = _instance {
            return existing                 // Fast path: already initialized, skip the lock
        }

        return lock.withLock {
            if let existing = _instance {
                return existing             // Another thread initialized it while we waited for the lock
            }
            let newInstance = factory()     // Create it for the first time
            _instance = newInstance         // Cache it for next time
            return newInstance
        }
    }

}
