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
 
    func handleNavigation(navigationController: UINavigationController,
                          data: Any?,
                          presentationStyle: NavigationPresentationStyle)
}

/// Centralized navigation handler that manages routing across the entire app
final class NavigationHandler: NavigationHandlerProtocol {
    
    private let factory: AppFactory
    private var routeFactories: [AppFeature: any RouteFactory] = [:]
    
    init(factory: AppFactory) {
        self.factory = factory
        setupRouteFactories()
    }
    
    private func setupRouteFactories() {
        routeFactories[.cats] = CatsRouteBuilder(factory: factory.catsFeatureFactory)
        routeFactories[.settings] = SettingsRouteBuilder(factory: factory.settingsFeatureFactory)
        routeFactories[.test] = TestRouteBuilder(factory: factory.testFeatureFactory)
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
        
        guard let routeFactory = routeFactories[route.feature],
              let viewController = routeFactory.createViewController(
                for: route,
                navigationController: navigationController,
                data: data
              ) else {
            print("❌ NavigationHandler: Unable to create view controller for route: \(route)")
            return
        }
       
        switch presentationStyle {
        case .push(let hideTabBar):
            navigationController.goToScreen(viewController, hideTabBar: hideTabBar)
            
        case .present:
            navigationController.presentScreen(viewController)
            
        case .presentFullscreen:
            navigationController.presentFullscreen(viewController)
            
        case .setAsRoot:
            navigationController.setRootViewController(viewController)
        default:
            return
        }
    }
 
    /// Central method to handle navigation without the need for a route
    /// - Parameters:
    ///   - navigationController: The navigation controller to use for navigation
    ///   - data: Optional data to pass between screens
    ///   - presentationStyle: How to navigate (.pop, .dismiss, etc.)
    func handleNavigation(navigationController: UINavigationController,
                          data: Any?,
                          presentationStyle: NavigationPresentationStyle) {
        
        switch presentationStyle {
        case .alert:
            guard let message = data as? String else { return }
            navigationController.showAlert(message: message)
        case .goBack:
            navigationController.goBack()
        case .dismiss:
            navigationController.dismiss()
        default:
            return
        }
    }
    
}

