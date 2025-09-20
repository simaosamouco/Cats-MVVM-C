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

final class TestViewCoordinator: TestViewCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
    }
    
    func goBack(_ isModallyPresented: Bool) {
        if isModallyPresented {
            coreCoordinator.dismiss()
        } else {
            coreCoordinator.goBack()
        }
    }
    
}
