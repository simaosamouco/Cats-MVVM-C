//
//  specifically.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Factory protocol specifically for creating Settings feature view controllers
protocol SettingsViewControllerFactoryProtocol {
    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController
    func createAboutViewController(navController: UINavigationController) -> AboutViewController
}

/// Factory for Settings feature routes
final class SettingsRouteFactory: RouteFactory {
    
    private let settingsFactory: SettingsViewControllerFactoryProtocol
    
    init(settingsFactory: SettingsViewControllerFactoryProtocol) {
        self.settingsFactory = settingsFactory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let settingsRoute = route as? SettingsRoute else {
            return nil
        }
        
        switch settingsRoute {
        case .settings:
            return settingsFactory.createSettingsViewController(navController: navigationController)
            
        case .about:
            return settingsFactory.createAboutViewController(navController: navigationController)
        }
    }
}
