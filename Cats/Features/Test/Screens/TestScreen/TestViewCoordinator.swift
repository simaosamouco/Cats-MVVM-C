//
//  TestCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import Foundation

protocol TestViewCoordinatorProtocol {
    func goBack(_ isModallyPresented: Bool)
}

/// Updated coordinator that uses the new route-based navigation system
final class TestViewCoordinator: TestViewCoordinatorProtocol, UniversalNavigationCoordinator {
    
    // MARK: - UniversalNavigationCoordinator Requirements
    let factory: FactoryProtocol
    let coreCoordinator: CoreCoordinatorProtocol
    let navigationHandler: NavigationHandlerProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.navigationHandler = navigationHandler
    }
    
    func goBack(_ isModallyPresented: Bool) {
        if isModallyPresented {
            coreCoordinator.dismiss()
        } else {
            coreCoordinator.goBack()
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