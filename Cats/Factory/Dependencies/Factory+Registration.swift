//
//  Factory+Registration.swift
//  Cats
//
//  Created by Simão Neves Samouco on 02/08/2025.
//

import Foundation
import SwiftData

extension Factory {
    
    /// Registers all of the dependencies that will be injected
    func registerDependencies() {

        /// LocalConfigUseCaseProtocol
        register(LocalConfigUseCaseProtocol.self, instance: LocalConfigUseCase())
        
        /// NetworkServiceProtocol
        register(NetworkServiceProtocol.self, instance: NetworkService())
        
        /// AppThemeUseCase
        let localConfig = resolve(LocalConfigUseCaseProtocol.self)
        register(AppThemeUseCaseProtocol.self, instance: AppThemeUseCase(
            localConfig: localConfig)
        )

        /// CatsServicesProtocol (lazy, resolves NetworkService when needed)
        registerLazy(CatsServicesProtocol.self) {
            let networkService = self.resolve(NetworkServiceProtocol.self)
            return CatsServices(networkService: networkService)
        }
        
        registerLazy(ImageCacheProtocol.self) {
            ImageCache()
        }
        
        registerLazy(ImageRepositoryProtocol.self) {
            let networkService = self.resolve(NetworkServiceProtocol.self)
            let imageCache = self.resolve(ImageCacheProtocol.self)
            return ImageRepository(networkService: networkService,
                                   imageCache: imageCache)
        }

        /// GetImageFromUrlUseCaseProtocol
        registerLazy(GetImageFromUrlUseCaseProtocol.self) {
            let imageRepository = self.resolve(ImageRepositoryProtocol.self)
            return GetImageFromUrlUseCase(imageRepository: imageRepository)
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

        /// CoreCoordinatorProtocol (factory with argument)
        registerFactory(CoreCoordinatorProtocol.self) { navigationController in
            return CoreCoordinator(navigationController: navigationController)
        }

        /// CatFilterUseCaseProtocol
        registerLazy(CatFilterUseCaseProtocol.self) {
            return CatFilterUseCase()
        }
    }
    
}
