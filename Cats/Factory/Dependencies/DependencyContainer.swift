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

// MARK: - Dependency Registration
//extension DependencyContainer {
//    
//    /// Registers all of the dependencies that will be injected
//    private func registerDependencies() {
//        
//        /// LocalConfigUseCaseProtocol
//        register(LocalConfigUseCaseProtocol.self, instance: LocalConfigUseCase())
//        
//        /// NetworkServiceProtocol
//        register(NetworkServiceProtocol.self, instance: NetworkService())
//        
//        /// AppThemeUseCase
//        registerLazy(AppThemeUseCaseProtocol.self) {
//            let localConfig = self.resolve(LocalConfigUseCaseProtocol.self)
//            return AppThemeUseCase(localConfig: localConfig)
//        }
//        
//        /// CatsServicesProtocol (lazy, resolves NetworkService when needed)
//        registerLazy(CatsServicesProtocol.self) {
//            let networkService = self.resolve(NetworkServiceProtocol.self)
//            return CatsServices(networkService: networkService)
//        }
//        
//        /// GetImageFromUrlUseCaseProtocol
//        registerLazy(GetImageFromUrlUseCaseProtocol.self) {
//            let networkService = self.resolve(NetworkServiceProtocol.self)
//            return GetImageFromUrlUseCase(networkService: networkService)
//        }
//        
//        /// ModelContainer
//        registerLazy(ModelContainer.self) {
//            do {
//                let types = PersistantModel.allCases.map { $0.type }
//                let schema = Schema(types)
//                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//                return try ModelContainer(for: schema, configurations: [modelConfiguration])
//            } catch {
//                fatalError("Could not create ModelContainer: \(error)")
//            }
//        }
//        
//        /// ModelContext
//        registerLazy(ModelContext.self) {
//            let container = self.resolve(ModelContainer.self)
//            return ModelContext(container)
//        }
//        
//        /// Cat Repository
//        registerLazy(SwiftDataRepositoryProtocol.self) {
//            let modelContext = self.resolve(ModelContext.self)
//            return SwiftDataRepository(modelContext: modelContext)
//        }
//        
//        /// CatsPersistanceUseCaseProtocol
//        registerLazy(CatsPersistanceUseCaseProtocol.self) {
//            let repository = self.resolve(SwiftDataRepositoryProtocol.self)
//            return CatsPersistanceUseCase(repository: repository)
//        }
//        
//        /// NavigationHandler (will be registered by AppFactory after creation)
//        // Note: NavigationHandler registration is handled by AppFactory to avoid circular dependency
//        
//        /// CoreCoordinatorProtocol (factory with argument)
//        registerFactory(CoreCoordinatorProtocol.self) { navigationController in
//            return CoreCoordinator(navigationController: navigationController)
//        }
//        
//        /// CatFilterUseCaseProtocol
//        registerLazy(CatFilterUseCaseProtocol.self) {
//            return CatFilterUseCase()
//        }
//        
//        /// TabBarCoordinatorProtocol (factory with argument - requires MainTabBarController)
//        registerFactory(TabBarCoordinatorProtocol.self) { (mainTabBarController: MainTabBarController) in
//            return mainTabBarController
//        }
//        
//    }
//    
//}
