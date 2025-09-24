//
//  MainTabView.swift
//  Cats
//
//  Created on 24/09/2025.
//

import SwiftUI
import UIKit

/// SwiftUI-based tab view that wraps existing UIViewController-based screens.
/// This allows migration from UITabBarController to SwiftUI TabView while
/// preserving existing view controller architecture.
struct MainTabView: View {
    private let factory: FactoryProtocol
    @State private var selectedTab: TabBarScreen = .catsList
    @StateObject private var tabBarCoordinator: TabBarCoordinator
    
    init(factory: FactoryProtocol) {
        self.factory = factory
        
        // Create the coordinator and register it with the factory
        let coordinator = TabBarCoordinator(selectedTab: .catsList)
        self._tabBarCoordinator = StateObject(wrappedValue: coordinator)
        
        // Register it with the dependency injection container
        factory.registerTabBarCoordinator(coordinator)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabBarScreen.allCases, id: \.self) { screen in
                createTabContent(for: screen)
                    .tabItem {
                        Image(uiImage: screen.image)
                        Text(screen.title)
                    }
                    .tag(screen)
            }
        }
        .onChange(of: selectedTab) { newTab in
            tabBarCoordinator.selectedTab = newTab
        }
        .onReceive(tabBarCoordinator.$selectedTab) { newTab in
            if selectedTab != newTab {
                selectedTab = newTab
            }
        }
        .environmentObject(tabBarCoordinator)
    }
    
    @ViewBuilder
    private func createTabContent(for screen: TabBarScreen) -> some View {
        Group {
            let navController = UINavigationController()
            
            if let viewController = screen.makeViewController(factory: factory, navController: navController) {
                let _ = navController.setViewControllers([viewController], animated: false)
                UIViewControllerWrapper(navController)
            } else {
                Text("Error loading \(screen.title)")
                    .foregroundStyle(.red)
            }
        }
    }
}

// MARK: - SwiftUI TabBar Coordinator
class TabBarCoordinator: ObservableObject, TabBarCoordinatorProtocol {
    @Published var selectedTab: TabBarScreen = .catsList
    
    init(selectedTab: TabBarScreen = .catsList) {
        self.selectedTab = selectedTab
    }
    
    func changeTab(to screen: TabBarScreen) {
        selectedTab = screen
    }
}

// MARK: - TabBarScreen Conformance to Hashable
extension TabBarScreen: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}