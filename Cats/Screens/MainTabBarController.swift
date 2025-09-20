//
//  MainTabBarController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func changeTab(to screen: TabBarScreen)
}

final class MainTabBarController: UITabBarController, TabBarCoordinatorProtocol {
    
    weak var factory: FactoryProtocol?
    
    init(factory: FactoryProtocol) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    /// Configures the `View Controllers` for the `TabBar`
    /// In a abstracted way considering `TabBarScreen`is self-contained
    /// Changes to the `TabBarScreen` `do not` require changes to this method.
    func configureTabs() {
        guard let factory else { return }
        tabBar.isTranslucent = true
        var controllers: [UIViewController?] = Array(repeating: nil,
                                                     count: TabBarScreen.allCases.count)

        for screen in TabBarScreen.allCases {
            let navController = UINavigationController()

            if let vc = screen.makeViewController(factory: factory, navController: navController) {
                vc.tabBarItem = UITabBarItem(
                    title: screen.title,
                    image: screen.image,
                    tag: screen.index
                )
                navController.setViewControllers([vc], animated: false)
                controllers[screen.index] = navController
            }
        }

        viewControllers = controllers.compactMap { $0 }
    }
    
    func changeTab(to screen: TabBarScreen) {
        self.selectedIndex = screen.index
    }
    
}


