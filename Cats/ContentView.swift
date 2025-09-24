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
    @StateObject private var themeObserver: ThemeObserver
    private let factory: FactoryProtocol
    private let appInitializer: AppInitializer
    
    init() {
        let factory = Factory()
        self.factory = factory
        
        let appThemeUseCase = factory.resolve(AppThemeUseCaseProtocol.self)
        self.appInitializer = AppInitializer(appThemeUseCase: appThemeUseCase)
        
        // Create theme observer with the theme use case
        self._themeObserver = StateObject(wrappedValue: ThemeObserver(appThemeUseCase: appThemeUseCase))
        
        // Configure navigation bar appearance (still needed for UIKit navigation controllers)
        appInitializer.configureNavigationBar()
    }
    
    var body: some View {
        MainTabView(factory: factory)
            .onAppear {
                // Configure theme and tab bar appearance when the view appears
                appInitializer.configureAppTheme()
                appInitializer.configureTabBar()
                
                // Start observing theme changes
                themeObserver.startObserving()
            }
            .environmentObject(themeObserver)
    }
}

/// Enhanced observable object to handle theme changes in SwiftUI and integrate with UIKit
class ThemeObserver: ObservableObject {
    @Published var currentTheme: Theme
    @Published var themeChangeId = UUID() // Forces UI refresh when theme changes
    
    private let appThemeUseCase: AppThemeUseCaseProtocol
    private var isObserving = false
    
    init(appThemeUseCase: AppThemeUseCaseProtocol) {
        self.appThemeUseCase = appThemeUseCase
        self.currentTheme = appThemeUseCase.getCurrentTheme()
    }
    
    func startObserving() {
        guard !isObserving else { return }
        isObserving = true
        
        // Listen for theme change notifications
        NotificationCenter.default.addObserver(
            forName: .themeDidChange,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleThemeChange()
        }
        
        // Also listen for system appearance changes
        NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.checkForThemeChange()
        }
    }
    
    private func handleThemeChange() {
        let newTheme = appThemeUseCase.getCurrentTheme()
        if newTheme != currentTheme {
            currentTheme = newTheme
            themeChangeId = UUID() // Force UI refresh
        }
    }
    
    private func checkForThemeChange() {
        // Check if theme changed (useful for system theme changes)
        handleThemeChange()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
