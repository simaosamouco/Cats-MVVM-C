//
//  DependencyContainer+Registration.swift
//  Cats
//
//  Created by Simão Neves Samouco on 09/10/2025.
//

import Foundation
import SwiftData

extension DependencyContainer {
    
    /// Registers all of the dependencies that will be injected
    func registerDependencies() {
        
        /// LocalConfigUseCaseProtocol
        register(LocalConfigUseCaseProtocol.self, instance: LocalConfigUseCase())
        
        /// NetworkServiceProtocol
        register(NetworkServiceProtocol.self, instance: NetworkService())
        
        /// AppThemeUseCase
        registerLazy(AppThemeUseCaseProtocol.self) {
            let localConfig = self.resolve(LocalConfigUseCaseProtocol.self)
            return AppThemeUseCase(localConfig: localConfig)
        }
        
        /// CatsServicesProtocol (lazy, resolves NetworkService when needed)
        registerLazy(CatsServicesProtocol.self) {
            let networkService = self.resolve(NetworkServiceProtocol.self)
            return CatsServices(networkService: networkService)
        }
        
        /// GetImageFromUrlUseCaseProtocol
        registerLazy(GetImageFromUrlUseCaseProtocol.self) {
            let networkService = self.resolve(NetworkServiceProtocol.self)
            return GetImageFromUrlUseCase(networkService: networkService)
        }
        
        /// ModelContainer
        registerLazy(ModelContainer.self) {
            do {
                let types = PersistantModel.allCases.map { $0.type }
                let schema = Schema(types)
                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
        
        /// ModelContext
        registerLazy(ModelContext.self) {
            let container = self.resolve(ModelContainer.self)
            return ModelContext(container)
        }
        
        /// Cat Repository
        registerLazy(SwiftDataRepositoryProtocol.self) {
            let modelContext = self.resolve(ModelContext.self)
            return SwiftDataRepository(modelContext: modelContext)
        }
        
        /// CatsPersistanceUseCaseProtocol
        registerLazy(CatsPersistanceUseCaseProtocol.self) {
            let repository = self.resolve(SwiftDataRepositoryProtocol.self)
            return CatsPersistanceUseCase(repository: repository)
        }
        
        /// NavigationHandler (will be registered by AppFactory after creation)
        // Note: NavigationHandler registration is handled by AppFactory to avoid circular dependency
        
        /// CoreCoordinatorProtocol (factory with argument)
        registerFactory(CoreCoordinatorProtocol.self) { navigationController in
            return CoreCoordinator(navigationController: navigationController)
        }
        
        /// CatFilterUseCaseProtocol
        registerLazy(CatFilterUseCaseProtocol.self) {
            return CatFilterUseCase()
        }
        
        /// TabBarCoordinatorProtocol (factory with argument - requires MainTabBarController)
        registerFactory(TabBarCoordinatorProtocol.self) { (mainTabBarController: MainTabBarController) in
            return mainTabBarController
        }
        
    }
    
}
