//
//  TestViewControllerFactoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

protocol TestViewControllerFactoryProtocol {
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController
}

/// Factory for Test feature routes
final class TestRouteFactory: RouteFactory {
    
    private let testFactory: TestViewControllerFactoryProtocol
    
    init(testFactory: TestViewControllerFactoryProtocol) {
        self.testFactory = testFactory
    }
    
    func createViewController(for route: any Route, 
                            navigationController: UINavigationController,
                            data: Any?) -> UIViewController? {
        
        guard let testRoute = route as? TestRoute else {
            return nil
        }
        
        switch testRoute {
        case .test(let isModallyPresented):
            return testFactory.createTestViewController(
                navController: navigationController,
                isModallyPresented: isModallyPresented
            )
        }
    }
}
