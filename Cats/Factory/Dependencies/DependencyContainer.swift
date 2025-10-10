//
//  DependencyContainer.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import Foundation
import SwiftData

/// A dedicated dependency injection container
final class DependencyContainer: DependencyInjectionProtocol {
    
    var dependencies: [String: Any] = [:]
    
    init() {
        registerDependencies()
    }
    
    // MARK: - DependencyInjectionProtocol Implementation
    
    func registerLazy<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = Lazy(factory: factory)
    }

    func register<T>(_ type: T.Type, instance: @escaping @autoclosure () -> T) {
        let key = String(describing: type)
        dependencies[key] = Lazy(factory: instance)
    }
    
    func registerFactory<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }

    func registerFactory<T, Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }

    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)

        if let lazy = dependencies[key] as? Lazy<T> {
            return lazy.instance
        }

        if let service = dependencies[key] as? T {
            return service
        }
        
        if let factory = dependencies[key] as? () -> T {
            return factory()
        }

        fatalError("Could not resolve dependency for type \(type). Make sure it's registered first.")
    }

    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        let key = String(describing: type)

        if let factory = dependencies[key] as? (Arg) -> T {
            return factory(argument)
        }

        fatalError("Could not resolve dependency with argument for type \(type). Make sure it's registered with an argument factory.")
    }
}
