//
//  CoordinatorNavigationExtension.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/10/2025.
//

import Foundation

/// Protocol that all coordinators should adopt to get universal navigation capabilities
protocol UniversalNavigationCoordinator {
    var factory: FactoryProtocol { get }
    var coreCoordinator: CoreCoordinatorProtocol { get }
    var navigationHandler: NavigationHandlerProtocol { get }
}

/// Extension that provides universal navigation to all coordinators
extension UniversalNavigationCoordinator {
    
    /// Universal navigation method - any coordinator can call this to go anywhere in the app!
    /// This is exactly what you wanted: handleNavigation(for route: Route, with object: Any)
    /// - Parameters:
    ///   - route: The route to navigate to (can be any feature's route)
    ///   - object: Optional data to pass between screens
    ///   - presentationStyle: How to present the screen (defaults to push)
    func handleNavigation(for route: any Route, 
                         with object: Any? = nil,
                         presentationStyle: NavigationPresentationStyle = .push(hideTabBar: false)) {
        navigationHandler.handleNavigation(
            for: route,
            from: coreCoordinator,
            data: object,
            presentationStyle: presentationStyle
        )
    }
    
}