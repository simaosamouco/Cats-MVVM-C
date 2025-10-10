//
//  SettingsFeatureFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

protocol SettingsViewControllerFactoryProtocol {
    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController
    func createAboutViewController(navController: UINavigationController) -> AboutViewController
}

/// Self-contained factory for Settings feature view controllers
final class SettingsFeatureFactory: SettingsViewControllerFactoryProtocol {
    
    private let container: DependenciesResolverProtocol
    
    init(container: DependenciesResolverProtocol) {
        self.container = container
    }
    
    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController {
        let tabBarCoordinator = container.resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        let appThemeUseCase = container.resolve(AppThemeUseCaseProtocol.self)
        
        return SettingsViewController(
            viewModel: SettingsViewModel(
                coordinator: SettingsCoordinator(
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler,
                    navigationController: navController
                ),
                appThemeUseCase: appThemeUseCase
            )
        )
    }
    
    func createAboutViewController(navController: UINavigationController) -> AboutViewController {
        let tabBarCoordinator = container.resolve(TabBarCoordinatorProtocol.self)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        
        return AboutViewController(
            viewModel: AboutViewModel(
                coordinator: AboutViewCoordinator(
                    tabBarCoordinator: tabBarCoordinator,
                    navigationHandler: navigationHandler,
                    navigationController: navController
                )
            )
        )
    }
}
