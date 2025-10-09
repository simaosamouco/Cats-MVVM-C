//
//  TestFeatureFactory.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import UIKit

protocol TestViewControllerFactoryProtocol {
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController
}

/// Self-contained factory for Test feature view controllers
final class TestFeatureFactory: TestViewControllerFactoryProtocol {
    
    private let container: DependenciesResolverProtocol
    
    init(container: DependenciesResolverProtocol) {
        self.container = container
    }
    
    func createTestViewController(navController: UINavigationController, isModallyPresented: Bool) -> TestViewController {
        let coreCoordinator = container.resolve(CoreCoordinatorProtocol.self, argument: navController)
        let navigationHandler = container.resolve(NavigationHandlerProtocol.self)
        
        return TestViewController(
            viewModel: TestViewModel(
                coordinator: TestViewCoordinator(
                    coreCoordinator: coreCoordinator,
                    navigationHandler: navigationHandler
                ), 
                isModallyPresented: isModallyPresented
            )
        )
    }
}
