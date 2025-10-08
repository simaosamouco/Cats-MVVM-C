//
//  AboutCoordinator.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import Foundation

protocol AboutViewCoordinatorProtocol {
    func presentModal()
    func presentModalFullscreen()
    func push()
    func changeTab()
}

/// Updated coordinator that uses the new route-based navigation system
final class AboutViewCoordinator: AboutViewCoordinatorProtocol, UniversalNavigationCoordinator {
    
    // MARK: - UniversalNavigationCoordinator Requirements
    let factory: FactoryProtocol
    let coreCoordinator: CoreCoordinatorProtocol
    let navigationHandler: NavigationHandlerProtocol
    
    // MARK: - Private Properties
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol,
         navigationHandler: NavigationHandlerProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
        self.navigationHandler = navigationHandler
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