//
//  NavigationHandler.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/10/2025.
//

import UIKit

/// Protocol for navigation handling
protocol NavigationHandlerProtocol {
    func handleNavigation(for route: any Route,
                          navigationController: UINavigationController,
                          data: Any?,
                          presentationStyle: NavigationPresentationStyle)
    
    func handleNavigation(for route: any Route,
                          from coreCoordinator: CoreCoordinatorProtocol,
                          data: Any?,
                          presentationStyle: NavigationPresentationStyle)
}

/// Centralized navigation handler that manages routing across the entire app
final class NavigationHandler: NavigationHandlerProtocol {
    
    private let factory: Factory // Use concrete Factory type since it implements all protocols
    private var routeFactories: [AppFeature: any RouteFactory] = [:]
    
    init(factory: Factory) {
        self.factory = factory
        setupRouteFactories()
    }
    
    private func setupRouteFactories() {
        routeFactories[.cats] = CatsRouteFactory(catsFactory: factory)
        routeFactories[.settings] = SettingsRouteFactory(settingsFactory: factory)
        routeFactories[.test] = TestRouteFactory(testFactory: factory)
    }
    
    /// Central method to handle navigation to any route in the app
    /// - Parameters:
    ///   - route: The route to navigate to
    ///   - navigationController: The navigation controller to use for navigation
    ///   - data: Optional data to pass between screens
    ///   - presentationStyle: How to present the screen (push, present, etc.)
    func handleNavigation(for route: any Route,
                          navigationController: UINavigationController,
                          data: Any? = nil,
                          presentationStyle: NavigationPresentationStyle = .push(hideTabBar: false)) {
        
        guard let factory = routeFactories[route.feature],
              let viewController = factory.createViewController(
                for: route,
                navigationController: navigationController,
                data: data
              ) else {
            print("❌ NavigationHandler: Unable to create view controller for route: \(route)")
            return
        }
        
        let coreCoordinator = CoreCoordinator(navigationController: navigationController)
        
        switch presentationStyle {
        case .push(let hideTabBar):
            coreCoordinator.goToScreen(viewController, hideTabBar: hideTabBar)
            
        case .present:
            coreCoordinator.presentScreen(viewController)
            
        case .presentFullscreen:
            coreCoordinator.presentFullscreen(viewController)
            
        case .setAsRoot:
            coreCoordinator.setRootViewController(viewController)
        }
    }
    
    /// Convenience method for handling navigation from any coordinator
    /// - Parameters:
    ///   - route: The route to navigate to
    ///   - coreCoordinator: The core coordinator that provides the navigation controller
    ///   - data: Optional data to pass between screens
    ///   - presentationStyle: How to present the screen
    func handleNavigation(for route: any Route,
                          from coreCoordinator: CoreCoordinatorProtocol,
                          data: Any? = nil,
                          presentationStyle: NavigationPresentationStyle = .push(hideTabBar: false)) {
        
        handleNavigation(
            for: route,
            navigationController: coreCoordinator.navigationController,
            data: data,
            presentationStyle: presentationStyle
        )
    }
}

