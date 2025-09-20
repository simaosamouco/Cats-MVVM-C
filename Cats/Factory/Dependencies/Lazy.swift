//
//  Lazy.swift
//  Cats
//
//  Created by Simão Neves Samouco on 10/09/2025.
//

/// A wrapper that ensures lazy initialization of instances.
/// The instance is created only once, on first access, and then cached.
final class Lazy<T> {
    
    private let factory: () -> T            // Stores HOW to create the instance
    private var _instance: T?               // Stores the actual instance

    /// Creates a new lazy wrapper with the provided factory closure.
    /// - Parameter factory: A closure that creates the instance when needed
    init(factory: @escaping () -> T) {
        self.factory = factory              // Save the creation closure
    }

    /// Gets the instance, creating it lazily on first access.
    /// Subsequent accesses return the cached instance.
    var instance: T {
        if let existing = _instance {
            return existing                 // Return cached instance
        }
        let newInstance = factory()         // Create it for the first time
        _instance = newInstance             // Cache it for next time
        return newInstance
    }
    
}
