//
//  Factory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

import UIKit

protocol FactoryProtocol: AnyObject {
    func createTabBarController() -> MainTabBarController
}

// MARK: - Extend Factory to implement specific protocols
extension FactoryProtocol where Self: CatsViewControllerFactoryProtocol & SettingsViewControllerFactoryProtocol & TestViewControllerFactoryProtocol {
    // This ensures the main factory can still be used where needed
}

final class Factory: FactoryProtocol,
                     CatsViewControllerFactoryProtocol,
                     SettingsViewControllerFactoryProtocol,
                     TestViewControllerFactoryProtocol {
    
    var dependencies: [String: Any] = [:]
    
    init() {
        registerDependencies()
    }
    
    func createTabBarController() -> MainTabBarController {
        let tabCoor = MainTabBarController(factory: self)
        register(TabBarCoordinatorProtocol.self, instance: tabCoor)
        return tabCoor
    }
    
    func createCatsListController(navController: UINavigationController) -> CatsListViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = resolve(NavigationHandlerProtocol.self)
        let catsServices = resolve(CatsServicesProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let catFilterUseCase = resolve(CatFilterUseCaseProtocol.self)
        return CatsListViewController(
            viewModel: CatsListViewModel(
                coordinator: CatsListCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler
                ), catsService: catsServices,
                getImageFromUrlUseCase: getImageUseCase,
                catsPersistanceUseCase: catsPersistanceUseCase,
                catFilterUseCase: catFilterUseCase
            )
        )
    }
    
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = resolve(NavigationHandlerProtocol.self)
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        return SavedCatsViewController(
            viewModel: SavedCatsViewModel(
                coordinator: SavedCatsCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler
                ),
                catsPersistanceUseCase: catsPersistanceUseCase,
                getImageFromUrlUseCase: getImageUseCase
            )
        )
    }
    
    func createProfileViewController(navController: UINavigationController,
                                     cat: CatProfileModel) -> ProfileViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = resolve(NavigationHandlerProtocol.self)
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        return ProfileViewController(
            viewModel: ProfileViewModel(
                catProfile: cat,
                coordinator: ProfileViewCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler
                ),
                catsPersistanceUseCase: catsPersistanceUseCase,
                getImageFromUrlUseCase: getImageUseCase
            )
        )
    }
    
    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = resolve(NavigationHandlerProtocol.self)
        let appThemeUseCase = resolve(AppThemeUseCaseProtocol.self)
        return SettingsViewController(
            viewModel: SettingsViewModel(
                coordinator: SettingsCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler
                ),
                appThemeUseCase: appThemeUseCase
            )
        )
    }
    
      func createAboutViewController(navController: UINavigationController) -> AboutViewController {
          let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                        argument: navController)
          let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
          let navigationHandler = resolve(NavigationHandlerProtocol.self)
          return AboutViewController(
              viewModel: AboutViewModel(
                  coordinator: AboutViewCoordinator(
                      factory: self,
                      coreCoordinator: coreCoordinator,
                      tabBarCoordinator: tabBarCoordinator,
                      navigationHandler: navigationHandler
                  )
              )
          )
      }
    
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController {
          let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                        argument: navController)
          let navigationHandler = resolve(NavigationHandlerProtocol.self)
          return TestViewController(
              viewModel: TestViewModel(
                  coordinator: TestViewCoordinator(
                      factory: self,
                      coreCoordinator: coreCoordinator,
                      navigationHandler: navigationHandler
                  ), isModallyPresented: isModallyPresented
              )
          )
      }
    
}
