//
//  CatsRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/10/2025.
//

import UIKit

/// Factory responsible for creating view controllers for Cats feature routes
final class CatsRouteBuilder: RouteFactory {
    
    private let factory: CatsViewControllerFactoryProtocol
    
    init(factory: CatsViewControllerFactoryProtocol) {
        self.factory = factory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let catsRoute = route as? CatsRoute else {
            return nil
        }
        
        switch catsRoute {
        case .catListAPI:
            return factory.createCatsListController(navController: navigationController)
            
        case .savedCats:
            return factory.createSavedCatsViewController(navController: navigationController)
            
        case .catProfile:
            guard let cat = data as? Cat else {
                assertionFailure("CatsRoute.catProfile requires Cat data")
                return nil
            }
            return factory.createProfileViewController(
                navController: navigationController,
                cat: cat.toCatProfile()
            )
        }
    }
}
