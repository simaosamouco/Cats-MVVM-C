//
//  SettingsCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import UIKit

protocol SettingsCoordinatorProtocol {
    func goToAboutScreen()
}

/// Updated coordinator that uses the new route-based navigation system
final class SettingsCoordinator: SettingsCoordinatorProtocol, UniversalNavigationCoordinator {
    
    var navigationController: UINavigationController
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol,
         navigationController: UINavigationController) {
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
        self.navigationController = navigationController
    }
    
    func goToAboutScreen() {
        handleNavigation(
            for: SettingsRoute.about,
            presentationStyle: .push(hideTabBar: true)
        )
    }
    
}
