//
//  ProfileCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import UIKit

protocol ProfileViewCoordinatorProtocol  {
    func showError(_ error: Error)
}

/// Updated coordinator that uses the new route-based navigation system
final class ProfileViewCoordinator: ProfileViewCoordinatorProtocol,
                                    UniversalNavigationCoordinator {
    
    let navigationController: UINavigationController
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol,
         navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
    }
    
    func showError(_ error: Error) {
        //coreCoordinator.showAlert(message: error.displayMessage)
        handleNavigation(with: error.displayMessage,
                         presentationStyle: .alert)
    }
    
    // MARK: - Example navigation methods (can be added as needed)
    
    /// Example: Navigate to settings from profile
    func goToSettings() {
        handleNavigation(for: SettingsRoute.settings)
    }
    
    /// Example: Navigate to saved cats
    func goToSavedCats() {
        handleNavigation(for: CatsRoute.savedCats)
    }
    
}
