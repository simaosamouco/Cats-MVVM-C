//
//  SettingsCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import Foundation

protocol SettingsCoordinatorProtocol {
    func goToAboutScreen()
}

/// Updated coordinator that uses the new route-based navigation system
final class SettingsCoordinator: SettingsCoordinatorProtocol, UniversalNavigationCoordinator {
    
    let coreCoordinator: CoreCoordinatorProtocol
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol) {
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
    }
    
    func goToAboutScreen() {
        handleNavigation(
            for: SettingsRoute.about,
            presentationStyle: .push(hideTabBar: true)
        )
    }
    
}
