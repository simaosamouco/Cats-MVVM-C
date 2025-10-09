//
//  AppFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Main factory protocol that defines the core app factory interface
protocol FactoryProtocol: AnyObject {
    func createTabBarController() -> MainTabBarController
}

/// Main application factory that serves as the composition root
final class AppFactory: FactoryProtocol {
    
    private let container: DependencyContainer
    private let catsFactory: CatsFeatureFactory
    private let settingsFactory: SettingsFeatureFactory
    private let testFactory: TestFeatureFactory
    
    init() {
        // Initialize the dependency container
        container = DependencyContainer()
        
        // Initialize feature factories with the container
        catsFactory = CatsFeatureFactory(container: container)
        settingsFactory = SettingsFeatureFactory(container: container)
        testFactory = TestFeatureFactory(container: container)
        
        // Register factory-dependent services
        registerFactoryDependentServices()
    }
    
    /// Registers services that depend on the factory instance
    private func registerFactoryDependentServices() {
        container.registerLazy(NavigationHandlerProtocol.self) { [weak self] in
            guard let self = self else { 
                fatalError("AppFactory was deallocated during NavigationHandler creation")
            }
            return NavigationHandler(factory: self)
        }
    }
    
    func createTabBarController() -> MainTabBarController {
        let tabBarController = MainTabBarController(factory: self)
        
        // Register the tab bar controller as the coordinator
        container.register(TabBarCoordinatorProtocol.self,
                           instance: tabBarController)
        
        return tabBarController
    }
    
    // MARK: - Feature Factory Access
    
    /// Provides access to the cats feature factory
    var catsFeatureFactory: CatsFeatureFactory {
        return catsFactory
    }
    
    /// Provides access to the settings feature factory
    var settingsFeatureFactory: SettingsFeatureFactory {
        return settingsFactory
    }
    
    /// Provides access to the test feature factory
    var testFeatureFactory: TestFeatureFactory {
        return testFactory
    }
    
    /// Direct access to dependency container if needed
    var dependencyContainer: DependenciesResolverProtocol {
        return container
    }
}
