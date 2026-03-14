//
//  SavedCatsCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import Foundation

protocol SavedCatsCoordinatorProtocol {
    func changeTab(to screen: TabBarScreen)
    func showError(_ error: Error)
    func goToCatProfile(_ cat: Cat)
}

final class SavedCatsCoordinator: SavedCatsCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private weak var tabBarCoordinator: TabBarCoordinatorProtocol?
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func changeTab(to screen: TabBarScreen) {
        tabBarCoordinator?.changeTab(to: screen)
    }

    func showError(_ error: Error) {
        coreCoordinator.showAlert(message: error.displayMessage)
    }
    
    func goToCatProfile(_ cat: Cat) {
        let profileVC = factory.createProfileViewController(
            navController: coreCoordinator.navigationController,
            cat: cat
        )
        coreCoordinator.goToScreen(profileVC)
    }
    
}
