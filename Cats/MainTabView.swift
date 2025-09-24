//
//  MainTabView.swift
//  Cats
//
//  Created on 24/09/2025.
//

import SwiftUI
import UIKit

/// SwiftUI-based tab view with custom tab bar design that wraps existing UIViewController-based screens.
/// Features a modern custom tab bar with smooth animations and glassmorphism effects.
struct MainTabView: View {
    private let factory: FactoryProtocol
    @State private var selectedTab: TabBarScreen = .catsList
    @StateObject private var tabBarCoordinator: TabBarCoordinator
    @Namespace private var tabBarAnimation
    @EnvironmentObject private var themeObserver: ThemeObserver
    
    // Store navigation controllers persistently
    @State private var navigationControllers: [TabBarScreen: UINavigationController] = [:]
    
    init(factory: FactoryProtocol) {
        self.factory = factory
        
        // Create the coordinator and register it with the factory
        let coordinator = TabBarCoordinator(selectedTab: .catsList)
        self._tabBarCoordinator = StateObject(wrappedValue: coordinator)
        
        // Register it with the dependency injection container
        factory.registerTabBarCoordinator(coordinator)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content - Use persistent controllers
            ForEach(TabBarScreen.allCases, id: \.self) { screen in
                createTabContent(for: screen)
                    .opacity(selectedTab == screen ? 1.0 : 0.0)
                    .allowsHitTesting(selectedTab == screen)
                    .animation(.easeInOut(duration: 0.2), value: selectedTab)
            }
            
            // Custom Tab Bar
            CustomTabBar(
                selectedTab: $selectedTab,
                tabBarCoordinator: tabBarCoordinator,
                namespace: tabBarAnimation
            )
        }
        .onAppear {
            // Initialize navigation controllers for all tabs
            setupNavigationControllers()
            // Trigger initial appearance for the selected tab
            triggerViewControllerLifecycle(for: selectedTab)
        }
        .onChange(of: selectedTab) { oldTab, newTab in
            tabBarCoordinator.selectedTab = newTab
            // Trigger disappearance for old tab and appearance for new tab
            triggerViewControllerDisappearance(for: oldTab)
            triggerViewControllerLifecycle(for: newTab)
        }
        .onReceive(tabBarCoordinator.$selectedTab) { newTab in
            if selectedTab != newTab {
                let oldTab = selectedTab
                selectedTab = newTab
                // Trigger disappearance for old tab and appearance for new tab
                triggerViewControllerDisappearance(for: oldTab)
                triggerViewControllerLifecycle(for: newTab)
            }
        }
        .environmentObject(tabBarCoordinator)
    }
    
    private func setupNavigationControllers() {
        for screen in TabBarScreen.allCases {
            if navigationControllers[screen] == nil {
                let navController = UINavigationController()
                if let viewController = screen.makeViewController(factory: factory, navController: navController) {
                    navController.setViewControllers([viewController], animated: false)
                    navigationControllers[screen] = navController
                }
            }
        }
    }
    
    private func triggerViewControllerLifecycle(for screen: TabBarScreen) {
        guard let navController = navigationControllers[screen],
              let topViewController = navController.topViewController else { return }
        
        // Manually trigger the UIKit lifecycle methods since SwiftUI opacity changes
        // don't automatically trigger them when view controllers are embedded
        DispatchQueue.main.async {
            // Ensure the view is loaded
            _ = topViewController.view
            
            // Trigger proper lifecycle sequence
            topViewController.viewWillAppear(false)
            topViewController.viewDidAppear(false)
        }
    }
    
    private func triggerViewControllerDisappearance(for screen: TabBarScreen) {
        guard let navController = navigationControllers[screen],
              let topViewController = navController.topViewController else { return }
        
        // Manually trigger disappearance lifecycle
        DispatchQueue.main.async {
            topViewController.viewWillDisappear(false)
            topViewController.viewDidDisappear(false)
        }
    }
    
    @ViewBuilder
    private func createTabContent(for screen: TabBarScreen) -> some View {
        if let navController = navigationControllers[screen] {
            UIViewControllerWrapper(navController)
                .id("tab-\(screen.index)-theme-\(themeObserver.themeChangeId)")
                // This will force updates when theme changes
        } else {
            // Fallback while controllers are being set up
            Color.clear
                .onAppear {
                    setupNavigationControllers()
                }
        }
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: TabBarScreen
    let tabBarCoordinator: TabBarCoordinator
    let namespace: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarScreen.allCases, id: \.self) { screen in
                CustomTabBarItem(
                    screen: screen,
                    selectedTab: $selectedTab,
                    namespace: namespace
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            // Glassmorphism background
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 8)
        )
        .padding(.horizontal, 24)
        .padding(.bottom, 34) // Account for safe area
    }
}

// MARK: - Custom Tab Bar Item
struct CustomTabBarItem: View {
    let screen: TabBarScreen
    @Binding var selectedTab: TabBarScreen
    let namespace: Namespace.ID
    
    private var isSelected: Bool {
        selectedTab == screen
    }
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                selectedTab = screen
            }
        } label: {
            VStack(spacing: 4) {
                ZStack {
                    // Background highlight for selected state
                    if isSelected {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue.opacity(0.3), .purple.opacity(0.2)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 44, height: 44)
                            .matchedGeometryEffect(id: "selectedTab", in: namespace)
                    }
                    
                    // Icon with dynamic sizing and color
                    Image(uiImage: screen.image)
                        .renderingMode(.template)
                        .font(.system(size: isSelected ? 22 : 18, weight: .medium))
                        .foregroundStyle(
                            isSelected ? 
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [.gray, .gray],
                                    startPoint: .center,
                                    endPoint: .center
                                )
                        )
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                }
                .frame(width: 44, height: 44)
                
                // Title with dynamic styling
                Text(screen.title)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                    .foregroundStyle(
                        isSelected ? 
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ) :
                            LinearGradient(
                                colors: [.gray, .gray],
                                startPoint: .center,
                                endPoint: .center
                            )
                    )
                    .opacity(isSelected ? 1.0 : 0.7)
            }
        }
        .buttonStyle(TabBarButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Custom Button Style
struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - SwiftUI TabBar Coordinator
class TabBarCoordinator: ObservableObject, TabBarCoordinatorProtocol {
    @Published var selectedTab: TabBarScreen = .catsList
    
    init(selectedTab: TabBarScreen = .catsList) {
        self.selectedTab = selectedTab
    }
    
    func changeTab(to screen: TabBarScreen) {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            selectedTab = screen
        }
    }
}

// MARK: - TabBarScreen Conformance to Hashable
extension TabBarScreen: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}