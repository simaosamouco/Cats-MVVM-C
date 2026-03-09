//
//  Factory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

import UIKit

protocol FactoryProtocol: AnyObject {
    
    func createTabBarController() -> MainTabBarController
    func createCatsListController(navController: UINavigationController) -> UIViewController
    func createSavedCatsViewController(navController: UINavigationController) -> UIViewController
    func createProfileViewController(navController: UINavigationController,
                                     cat: CatProfileModel) -> UIViewController
    func createSettingsViewController(navController: UINavigationController) -> UIViewController
    func createAboutViewController(navController: UINavigationController) -> UIViewController
    func createTestViewController(navController: UINavigationController,
                                  isModallyPresented: Bool) -> UIViewController
    
}

final class Factory: FactoryProtocol {
    
    var dependencies: [String: Any] = [:]
    let lock = NSLock()
    
    init() {
        registerDependencies()
    }
    
    func createTabBarController() -> MainTabBarController {
        let tabCoor = MainTabBarController(factory: self)
        register(TabBarCoordinatorProtocol.self, instance: tabCoor)
        return tabCoor
    }
    
    func createCatsListController(navController: UINavigationController) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let catRepository = resolve(RemoteCatsRepositoryProtocol.self)
        let getCatsUseCase = GetCatsUseCase(repository: catRepository)
        let catFilterUseCase = resolve(CatFilterUseCaseProtocol.self)
        let viewModel = CatsListViewModel(
            coordinator: CatsListCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator,
                tabBarCoordinator: tabBarCoordinator
            ), getCatsUseCase: getCatsUseCase,
            getImageFromUrlUseCase: getImageUseCase,
            catFilterUseCase: catFilterUseCase
        )
        let view = CatsListView(viewModel: viewModel)
        return CatsListViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
    func createSavedCatsViewController(navController: UINavigationController) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let catRepository = resolve(LocalCatsRepositoryProtocol.self)
        let getCatsUseCase = GetCatsUseCase(repository: catRepository)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let viewModel = SavedCatsViewModel(
            coordinator: SavedCatsCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator,
                tabBarCoordinator: tabBarCoordinator
            ),
            getCatsUseCase: getCatsUseCase,
            getImageFromUrlUseCase: getImageUseCase
        )
        let view = SavedCatsView(viewModel: viewModel)
        return SavedCatsViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
    func createProfileViewController(navController: UINavigationController,
                                     cat: CatProfileModel) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let viewModel = ProfileViewModel(
            catProfile: cat,
            coordinator: ProfileViewCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator
            ),
            catsPersistanceUseCase: catsPersistanceUseCase,
            getImageFromUrlUseCase: getImageUseCase
        )
        let view = ProfileView(viewModel: viewModel)
        return ProfileViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
    func createSettingsViewController(navController: UINavigationController) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let appThemeUseCase = resolve(AppThemeUseCaseProtocol.self)
        let viewModel = SettingsViewModel(
            coordinator: SettingsCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator
            ),
            appThemeUseCase: appThemeUseCase
        )
        let view = SettingsView(viewModel: viewModel)
        return SettingsViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
    func createAboutViewController(navController: UINavigationController) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let viewModel = AboutViewModel(
            coordinator: AboutViewCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator,
                tabBarCoordinator: tabBarCoordinator
            )
        )
        let view = AboutView(viewModel: viewModel)
        return AboutViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
    func createTestViewController(navController: UINavigationController,
                                  isModallyPresented: Bool) -> UIViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let viewModel = TestViewModel(
            coordinator: TestViewCoordinator(
                factory: self,
                coreCoordinator: coreCoordinator
            ), isModallyPresented: isModallyPresented
        )
        let view = TestView(viewModel: viewModel)
        return TestViewController(
            view: view,
            viewModel: viewModel
        )
    }
    
}
