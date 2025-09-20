//
//  SettingsCoordinator.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import Foundation

protocol SettingsCoordinatorProtocol {
    func goToAboutScreen()
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    
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
    
    func goToAboutScreen() {
        let aboutVC = factory.createAboutViewController(
            navController: coreCoordinator.navigationController
        )
        coreCoordinator.goToScreen(aboutVC)
    }
    
}
