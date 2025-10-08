//
//  CatsRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/10/2025.
//

import UIKit

// MARK: - Specific Factory Protocols (Following ISP)

/// Factory protocol specifically for creating Cats feature view controllers
protocol CatsViewControllerFactoryProtocol {
    func createCatsListController(navController: UINavigationController) -> CatsListViewController
    func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController
    func createProfileViewController(navController: UINavigationController, cat: CatProfileModel) -> ProfileViewController
}

/// Factory responsible for creating view controllers for Cats feature routes
final class CatsRouteFactory: RouteFactory {
    
    private let catsFactory: CatsViewControllerFactoryProtocol
    
    init(catsFactory: CatsViewControllerFactoryProtocol) {
        self.catsFactory = catsFactory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let catsRoute = route as? CatsRoute else {
            return nil
        }
        
        switch catsRoute {
        case .catListAPI:
            return catsFactory.createCatsListController(navController: navigationController)
            
        case .savedCats:
            return catsFactory.createSavedCatsViewController(navController: navigationController)
            
        case .catProfile:
            guard let cat = data as? Cat else {
                assertionFailure("CatsRoute.catProfile requires Cat data")
                return nil
            }
            return catsFactory.createProfileViewController(
                navController: navigationController,
                cat: cat.toCatProfile()
            )
        }
    }
}

// MARK: - Settings Factory

///// Factory protocol specifically for creating Settings feature view controllers
//protocol SettingsViewControllerFactoryProtocol {
//    func createSettingsViewController(navController: UINavigationController) -> SettingsViewController
//    func createAboutViewController(navController: UINavigationController) -> AboutViewController
//}
//
///// Factory for Settings feature routes
//final class SettingsRouteFactory: RouteFactory {
//    
//    private let settingsFactory: SettingsViewControllerFactoryProtocol
//    
//    init(settingsFactory: SettingsViewControllerFactoryProtocol) {
//        self.settingsFactory = settingsFactory
//    }
//    
//    func createViewController(for route: any Route, 
//                            navigationController: UINavigationController,
//                            data: Any?) -> UIViewController? {
//        
//        guard let settingsRoute = route as? SettingsRoute else {
//            return nil
//        }
//        
//        switch settingsRoute {
//        case .settings:
//            return settingsFactory.createSettingsViewController(navController: navigationController)
//            
//        case .about:
//            return settingsFactory.createAboutViewController(navController: navigationController)
//        }
//    }
//}

// MARK: - Test Factory

/// Factory protocol specifically for creating Test feature view controllers

