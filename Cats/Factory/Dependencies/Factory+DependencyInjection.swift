//
//  Factory+DependencyInjection.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

/// Protocol for registering dependencies in the container
protocol DependenciesRegisterProtocol {
    
    /// Registers a type with a factory closure that produces a new instance lazily.
    /// The instance will be created only when first resolved.
    /// - Parameters:
    ///   - type: The type to register
    ///   - factory: A closure that returns an instance of the type
    func registerLazy<T>(_ type: T.Type, factory: @escaping () -> T)
    
    /// Registers a type with a concrete instance that is created immediately.
    /// The instance is evaluated at registration time, not when resolved.
    /// Use this for lightweight objects or when you need immediate initialization.
    /// - Parameters:
    ///   - type: The type to register
    ///   - instance: An autoclosure producing the instance (evaluated immediately)
    func register<T>(_ type: T.Type, instance: @escaping @autoclosure () -> T)
    
    /// Registers a type with a factory closure that creates a NEW instance on each resolve.
    /// Unlike the standard register method, this does NOT cache instances.
    /// Useful for stateful objects, short-lived instances, or when you need fresh objects each time.
    /// - Parameters:
    ///   - type: The type to register
    ///   - factory: A closure that returns a new instance each time
    func registerFactory<T>(_ type: T.Type, factory: @escaping () -> T)
    
    /// Registers a type with a factory closure that takes an argument for construction.
    /// The factory is called each time the dependency is resolved with an argument.
    /// Useful when the type cannot be initialized without input data.
    /// - Parameters:
    ///   - type: The type to register
    ///   - factory: A closure that takes an argument and produces an instance
    func registerFactory<T, Arg>(_ type: T.Type, factory: @escaping (Arg) -> T)
}

/// Protocol for resolving dependencies from the container
protocol DependenciesResolverProtocol {
    
    /// Resolves a dependency of a given type.
    /// For lazily registered dependencies, will create the instance on first access.
    /// For immediately registered dependencies, returns the pre-created instance.
    /// - Parameter type: The type to resolve
    /// - Returns: An instance of the requested type
    /// - Note: Will crash with fatalError if the type is not registered
    func resolve<T>(_ type: T.Type) -> T
    
    /// Resolves a dependency of a given type that requires an input argument.
    /// Calls the registered factory closure with the provided argument.
    /// - Parameters:
    ///   - type: The type to resolve
    ///   - argument: Argument to pass to the factory closure
    /// - Returns: An instance of the requested type
    /// - Note: Will crash with fatalError if the type is not registered with an argument factory
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T
}

/// Convenience typealias combining registration and resolution protocols
typealias DependencyInjectionProtocol = DependenciesRegisterProtocol & DependenciesResolverProtocol

extension Factory: DependencyInjectionProtocol {

    /// Registers a type with lazy initialization using a factory closure.
    func registerLazy<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = Lazy(factory: factory)
    }

    /// Registers a type with immediate initialization using an autoclosure.
    /// Note: The instance is created immediately when this method is called.
    func register<T>(_ type: T.Type, instance: @escaping @autoclosure () -> T) {
        let key = String(describing: type)
        dependencies[key] = Lazy(factory: instance)
    }
    
    /// Registers a type with a factory.
    /// The factory is stored directly and called each time resolve is called.
    func registerFactory<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }

    /// Registers a type with a factory that requires an argument.
    /// The factory is stored directly and called each time resolve is called.
    func registerFactory<T, Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }

    /// Resolves a dependency by type, handling different storage strategies.
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)

        // Try lazy wrapper first (for factory-registered dependencies)
        if let lazy = dependencies[key] as? Lazy<T> {
            return lazy.instance
        }

        // Try direct instance (for pre-created objects)
        if let service = dependencies[key] as? T {
            return service
        }
        
        // Try direct factory closure (for fresh instances each time)
        if let factory = dependencies[key] as? () -> T {
            return factory()
        }

        fatalError("Could not resolve dependency for type \(type). Make sure it's registered first.")
    }

    /// Resolves a dependency that requires an argument.
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        let key = String(describing: type)

        if let factory = dependencies[key] as? (Arg) -> T {
            return factory(argument)
        }

        fatalError("Could not resolve dependency with argument for type \(type). Make sure it's registered with an argument factory.")
    }
    
}
