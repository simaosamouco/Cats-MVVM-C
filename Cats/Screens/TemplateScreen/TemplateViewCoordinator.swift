//
//  TemplateCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 23/09/2025.
//

import Foundation

protocol TemplateViewCoordinatorProtocol { }

final class TemplateViewCoordinator: TemplateViewCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
    }
    
}
