//
//  ProfileCoordinator.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import UIKit

protocol ProfileViewCoordinatorProtocol  {
    func showError(_ error: Error)
}

final class ProfileViewCoordinator: ProfileViewCoordinatorProtocol {
    
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
    
}
