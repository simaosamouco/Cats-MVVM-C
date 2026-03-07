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

final class ProfileViewCoordinator: ProfileViewCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
    }
    
    func showError(_ error: Error) {
        coreCoordinator.showAlert(message: error.displayMessage)
    }
    
}
