//
//  AboutCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import UIKit

protocol AboutViewCoordinatorProtocol {
    func presentModal()
    func presentModalFullscreen()
    func push()
    func changeTab()
}

/// Updated coordinator that uses the new route-based navigation system
final class AboutViewCoordinator: AboutViewCoordinatorProtocol, UniversalNavigationCoordinator {
    
    var navigationController: UINavigationController
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol,
         navigationController: UINavigationController) {
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
        self.navigationController = navigationController
    }
    
    func presentModal() {
        // Using the new route-based navigation system
        handleNavigation(
            for: TestRoute.test(isModallyPresented: true),
            presentationStyle: .present
        )
    }
    
    func presentModalFullscreen() {
        // Using the new route-based navigation system
        handleNavigation(
            for: TestRoute.test(isModallyPresented: true),
            presentationStyle: .presentFullscreen
        )
    }
    
    func push() {
        // Using the new route-based navigation system
        handleNavigation(
            for: TestRoute.test(isModallyPresented: false),
            presentationStyle: .push(hideTabBar: false)
        )
    }
    
    func changeTab() {
        tabBarCoordinator.changeTab(to: .catsList)
    }
    
    // MARK: - Additional navigation examples
    
    /// Example: Navigate to cat profile
    func goToCatProfile(_ cat: Cat) {
        handleNavigation(
            for: CatsRoute.catProfile,
            with: cat,
            presentationStyle: .push(hideTabBar: true)
        )
    }
    
    /// Example: Navigate to settings
    func goToSettings() {
        handleNavigation(for: SettingsRoute.settings)
    }
    
}
