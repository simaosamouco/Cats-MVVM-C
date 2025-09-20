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

final class CatsListCoordinator: CatsListCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func showError(_ error: Error) {
        coreCoordinator.showAlert(message: error.displayMessage)
    }
    
    func goToCatProfile(_ cat: Cat) {
        let profileVC = factory.createProfileViewController(
            navController: coreCoordinator.navigationController,
            cat: cat.toCatProfile()
        )
        coreCoordinator.goToScreen(profileVC)
    }
    
    func changeTab(to screen: TabBarScreen) {
        tabBarCoordinator.changeTab(to: screen)
    }
    
}
