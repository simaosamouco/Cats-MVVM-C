//
//  TestRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Factory for Test feature routes
final class TestRouteBuilder: RouteFactory {
    
    private let factory: TestFeatureFactory
    
    init(factory: TestFeatureFactory) {
        self.factory = factory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let testRoute = route as? TestRoute else {
            return nil
        }
        
        switch testRoute {
        case .test(let isModallyPresented):
            return factory.createTestViewController(
                navController: navigationController,
                isModallyPresented: isModallyPresented
            )
        }
    }
}
