//
//  TestCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import UIKit

protocol TestViewCoordinatorProtocol {
    func goBack(_ isModallyPresented: Bool)
}

/// Updated coordinator that uses the new route-based navigation system
final class TestViewCoordinator: TestViewCoordinatorProtocol, UniversalNavigationCoordinator {
    
    var navigationController: UINavigationController
    let navigationHandler: NavigationHandlerProtocol
    
    init(navigationHandler: NavigationHandlerProtocol,
         navigationController: UINavigationController) {
        self.navigationHandler = navigationHandler
        self.navigationController = navigationController
    }
    
    func goBack(_ isModallyPresented: Bool) {
        if isModallyPresented {
            //coreCoordinator.dismiss()
            handleNavigation(presentationStyle: .dismiss)
        } else {
            handleNavigation(presentationStyle: .goBack)
        }
    }
    
    // MARK: - Example navigation methods using new system
    
    /// Example: Navigate to cats list
    func goToCatsList() {
        handleNavigation(for: CatsRoute.catListAPI)
    }
    
    /// Example: Navigate to settings
    func goToSettings() {
        handleNavigation(for: SettingsRoute.settings)
    }
    
}
