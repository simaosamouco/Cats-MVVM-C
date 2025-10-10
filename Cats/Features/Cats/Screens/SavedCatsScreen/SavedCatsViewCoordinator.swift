//
//  SavedCatsCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import UIKit

protocol SavedCatsCoordinatorProtocol {
    func changeTab(to screen: TabBarScreen)
    func showError(_ error: Error)
    func goToCatProfile(_ cat: Cat)
}

/// Updated coordinator that uses the new route-based navigation system
final class SavedCatsCoordinator: SavedCatsCoordinatorProtocol, UniversalNavigationCoordinator {
    
    let navigationController: UINavigationController
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
    
    func changeTab(to screen: TabBarScreen) {
        tabBarCoordinator.changeTab(to: screen)
    }

    func showError(_ error: Error) {
        //coreCoordinator.showAlert(message: error.displayMessage)
        handleNavigation(with: error.displayMessage,
                         presentationStyle: .alert)
    }
    
    func goToCatProfile(_ cat: Cat) {
        // Using the new route-based navigation system
        handleNavigation(
            for: CatsRoute.catProfile,
            with: cat,
            presentationStyle: .push(hideTabBar: false)
        )
    }
    
}
