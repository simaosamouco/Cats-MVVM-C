//
//  CatsListCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import UIKit

protocol CatsListCoordinatorProtocol {
    func showError(_ error: Error)
    func goToCatProfile(_ cat: Cat)
    func changeTab(to screen: TabBarScreen)
}

final class CatsListCoordinator: CatsListCoordinatorProtocol, UniversalNavigationCoordinator {
    
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
    
    func showError(_ error: Error) {
        //coreCoordinator.showAlert(message: error.displayMessage)
        handleNavigation(with: error.displayMessage,
                         presentationStyle: .alert)
    }
    
    func goToCatProfile(_ cat: Cat) {
        handleNavigation(
            for: CatsRoute.catProfile,
            with: cat,
            presentationStyle: .push(hideTabBar: true)
        )
    }
    
    func changeTab(to screen: TabBarScreen) {
        tabBarCoordinator.changeTab(to: screen)
    }
    
}
