//
//  SettingsRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Factory for Settings feature routes
final class SettingsRouteBuilder: RouteFactory {
    
    private let factory: SettingsViewControllerFactoryProtocol
    
    init(factory: SettingsViewControllerFactoryProtocol) {
        self.factory = factory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let settingsRoute = route as? SettingsRoute else {
            return nil
        }
        
        switch settingsRoute {
        case .settings:
            return factory.createSettingsViewController(navController: navigationController)
            
        case .about:
            return factory.createAboutViewController(navController: navigationController)
        }
    }
}
