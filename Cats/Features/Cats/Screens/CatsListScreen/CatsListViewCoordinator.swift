//
//  CatsListCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import Foundation

protocol CatsListCoordinatorProtocol {
    
    func showError(_ error: Error)
    func goToCatProfile(_ cat: Cat)
    func changeTab(to screen: TabBarScreen)
    
}

final class CatsListCoordinator: CatsListCoordinatorProtocol, UniversalNavigationCoordinator {
    
    // MARK: - UniversalNavigationCoordinator Requirements
    let factory: FactoryProtocol
    let coreCoordinator: CoreCoordinatorProtocol
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
    }
    
    func showError(_ error: Error) {
        coreCoordinator.showAlert(message: error.displayMessage)
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
