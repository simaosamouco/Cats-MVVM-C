//
//  SettingsRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Factory for Settings feature routes
final class SettingsRouteFactory: RouteFactory {
    
    private let settingsFeatureFactory: SettingsViewControllerFactoryProtocol
    
    init(settingsFeatureFactory: SettingsViewControllerFactoryProtocol) {
        self.settingsFeatureFactory = settingsFeatureFactory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let settingsRoute = route as? SettingsRoute else {
            return nil
        }
        
        switch settingsRoute {
        case .settings:
            return settingsFeatureFactory.createSettingsViewController(navController: navigationController)
            
        case .about:
            return settingsFeatureFactory.createAboutViewController(navController: navigationController)
        }
    }
}
