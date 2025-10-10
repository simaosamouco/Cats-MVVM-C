//
//  CatsFeatureFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

protocol CatsViewControllerFactoryProtocol {
    func createCatsListController(navController: UINavigationController) -> CatsListViewController
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController
    func createProfileViewController(navController: UINavigationController, cat: CatProfileModel) -> ProfileViewController
}

/// Self-contained factory for Cats feature view controllers
final class CatsFeatureFactory: CatsViewControllerFactoryProtocol {
    
    private let container: DependenciesResolverProtocol
    
    init(container: DependenciesResolverProtocol) {
        self.container = container
    }
    
    func createCatsListController(navController: UINavigationController) -> CatsListViewController {
        let tabBarCoordinator = container.resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        let catsServices = container.resolve(CatsServicesProtocol.self)
        let getImageUseCase = container.resolve(GetImageFromUrlUseCaseProtocol.self)
        let catsPersistanceUseCase = container.resolve(CatsPersistanceUseCaseProtocol.self)
        let catFilterUseCase = container.resolve(CatFilterUseCaseProtocol.self)
        
        return CatsListViewController(
            viewModel: CatsListViewModel(
                coordinator: CatsListCoordinator(
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler,
                    navigationController: navController
                ),
                catsService: catsServices,
                getImageFromUrlUseCase: getImageUseCase,
                catsPersistanceUseCase: catsPersistanceUseCase,
                catFilterUseCase: catFilterUseCase
            )
        )
    }
    
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController {
        let tabBarCoordinator = container.resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        let catsPersistanceUseCase = container.resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = container.resolve(GetImageFromUrlUseCaseProtocol.self)
        
        return SavedCatsViewController(
            viewModel: SavedCatsViewModel(
                coordinator: SavedCatsCoordinator(
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler,
                    navigationController: navController
                ),
                catsPersistanceUseCase: catsPersistanceUseCase,
                getImageFromUrlUseCase: getImageUseCase
            )
        )
    }
    
    func createProfileViewController(navController: UINavigationController,
                                     cat: CatProfileModel) -> ProfileViewController {
        let tabBarCoordinator = container.resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        let catsPersistanceUseCase = container.resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = container.resolve(GetImageFromUrlUseCaseProtocol.self)
        
        return ProfileViewController(
            viewModel: ProfileViewModel(
                catProfile: cat,
                coordinator: ProfileViewCoordinator(
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler,
                    navigationController: navController
                ),
                catsPersistanceUseCase: catsPersistanceUseCase,
                getImageFromUrlUseCase: getImageUseCase
            )
        )
    }
}
