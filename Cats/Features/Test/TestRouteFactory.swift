//
//  TestRouteFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

/// Factory for Test feature routes
final class TestRouteFactory: RouteFactory {
    
    private let testFeatureFactory: TestFeatureFactory
    
    init(testFeatureFactory: TestFeatureFactory) {
        self.testFeatureFactory = testFeatureFactory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let testRoute = route as? TestRoute else {
            return nil
        }
        
        switch testRoute {
        case .test(let isModallyPresented):
            return testFeatureFactory.createTestViewController(
                navController: navigationController,
                isModallyPresented: isModallyPresented
            )
        }
    }
}
