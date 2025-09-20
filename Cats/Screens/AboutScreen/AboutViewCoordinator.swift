//
//  AboutCoordinator.swift
//  DogsTest
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

final class AboutViewCoordinator: AboutViewCoordinatorProtocol {
    
    private let factory: FactoryProtocol
    private let coreCoordinator: CoreCoordinatorProtocol
    private let tabBarCoordinator: TabBarCoordinatorProtocol
    
    init(factory: FactoryProtocol,
         coreCoordinator: CoreCoordinatorProtocol,
         tabBarCoordinator: TabBarCoordinatorProtocol) {
        self.factory = factory
        self.coreCoordinator = coreCoordinator
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func presentModal() {
        let testVC = factory.createTestViewController(
            navController: coreCoordinator.navigationController,
                                                      isModallyPresented: true
        )
        coreCoordinator.presentScreen(testVC)
    }
    
    func presentModalFullscreen() {
        let testVC = factory.createTestViewController(
            navController: coreCoordinator.navigationController,
                                                      isModallyPresented: true
        )
        coreCoordinator.presentFullscreen(testVC)
    }
    
    func push() {
        let testVC = factory.createTestViewController(
            navController: coreCoordinator.navigationController,
                                                      isModallyPresented: false
        )
        coreCoordinator.goToScreen(testVC)
    }
    
    func changeTab() {
        tabBarCoordinator.changeTab(to: .catsList)
    }
    
}
