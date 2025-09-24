//
//  ContentView.swift
//  Cats
//
//  Created on 24/09/2025.
//

import SwiftUI

/// Root SwiftUI view that initializes and configures the app.
/// This replaces the UIKit-based SceneDelegate setup for the main interface.
struct ContentView: View {
    @StateObject private var themeObserver = ThemeObserver()
    private let factory: FactoryProtocol
    private let appInitializer: AppInitializer
    
    init() {
        let factory = Factory()
        self.factory = factory
        
        let appThemeUseCase = factory.resolve(AppThemeUseCaseProtocol.self)
        self.appInitializer = AppInitializer(appThemeUseCase: appThemeUseCase)
        
        // Configure navigation bar appearance (still needed for UIKit navigation controllers)
        appInitializer.configureNavigationBar()
    }
    
    var body: some View {
        MainTabView(factory: factory)
            .onAppear {
                // Configure theme and tab bar appearance when the view appears
                appInitializer.configureAppTheme()
                appInitializer.configureTabBar()
            }
            .environmentObject(themeObserver)
    }
}

/// Observable object to handle theme changes in SwiftUI
class ThemeObserver: ObservableObject {
    @Published var currentTheme: Theme = .system
    
    init() {
        // You can integrate this with your existing theme system
        // For now, this is a placeholder
    }
}
