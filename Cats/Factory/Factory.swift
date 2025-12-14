//
//  Factory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

import UIKit

protocol FactoryProtocol: AnyObject {
    
    func createTabBarController() -> MainTabBarController
    func createCatsListController(navController: UINavigationController) -> CatsListViewController
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController
    func createProfileViewController(navController: UINavigationController,
                                     cat: CatProfileModel) -> ProfileViewController
    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController
    func createAboutViewController(navController: UINavigationController) -> AboutViewController
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController
    
}

final class Factory: FactoryProtocol {
    
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
        let catsServices = resolve(CatsServicesProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let catFilterUseCase = resolve(CatFilterUseCaseProtocol.self)
        return CatsListViewController(
            viewModel: CatsListViewModel(
                coordinator: CatsListCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator
                ), catsService: catsServices,
                getImageFromUrlUseCase: getImageUseCase,
                catFilterUseCase: catFilterUseCase
            )
        )
    }
    
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController {
        let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                      argument: navController)
        let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        return SavedCatsViewController(
            viewModel: SavedCatsViewModel(
                coordinator: SavedCatsCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator
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
        let catsPersistanceUseCase = resolve(CatsPersistanceUseCaseProtocol.self)
        let getImageUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        return ProfileViewController(
            viewModel: ProfileViewModel(
                catProfile: cat,
                coordinator: ProfileViewCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator
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
        let appThemeUseCase = resolve(AppThemeUseCaseProtocol.self)
        return SettingsViewController(
            viewModel: SettingsViewModel(
                coordinator: SettingsCoordinator(
                    factory: self,
                    coreCoordinator: coreCoordinator,
                    tabBarCoordinator: tabBarCoordinator
                ),
                appThemeUseCase: appThemeUseCase
            )
        )
    }
    
      func createAboutViewController(navController: UINavigationController) -> AboutViewController {
          let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                        argument: navController)
          let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
          return AboutViewController(
              viewModel: AboutViewModel(
                  coordinator: AboutViewCoordinator(
                      factory: self,
                      coreCoordinator: coreCoordinator,
                      tabBarCoordinator: tabBarCoordinator
                  )
              )
          )
      }
    
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController {
          let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
                                        argument: navController)
          return TestViewController(
              viewModel: TestViewModel(
                  coordinator: TestViewCoordinator(
                      factory: self,
                      coreCoordinator: coreCoordinator
                  ), isModallyPresented: isModallyPresented
              )
          )
      }
    
}
