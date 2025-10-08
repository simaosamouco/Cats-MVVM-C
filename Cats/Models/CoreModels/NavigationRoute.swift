//
//  Route.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/10/2025.
//

import UIKit

/// Base protocol that all app routes must conform to
protocol Route {
    /// Associated factory type that can handle this route
    associatedtype Factory: RouteFactory
    
    /// The feature this route belongs to
    var feature: AppFeature { get }
}

/// Defines all features in the app
enum AppFeature {
    case cats
    case settings
    case profile
    case test
    // Add more features as your app grows
}

/// Protocol that all route factories must conform to
protocol RouteFactory {
    /// Creates a view controller for the given route
    /// - Parameters:
    ///   - route: The specific route to navigate to
    ///   - navigationController: The navigation controller to use
    ///   - data: Optional data to pass between screens
    /// - Returns: The view controller for the route
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController?
}