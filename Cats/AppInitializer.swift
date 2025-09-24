//
//  AppInitializer.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import UIKit

/// A utility class responsible for initializing and configuring
/// global app-wide appearance and theme settings.
final class AppInitializer {
    
    private let appThemeUseCase: AppThemeUseCaseProtocol
    
    init(appThemeUseCase: AppThemeUseCaseProtocol) {
        self.appThemeUseCase = appThemeUseCase
    }

    /// Configures the app’s theme based on the current saved preference.
    /// Retrieves the active theme and applies it across the app.
    func configureAppTheme() {
        let theme = appThemeUseCase.getCurrentTheme()
        appThemeUseCase.switchTheme(to: theme)
    }
    
    /// Configures the appearance of the SwiftUI TabView.
    /// This method configures the underlying UITabBar appearance that SwiftUI uses.
    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        // Unselected items
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]

        // Selected items
        appearance.stackedLayoutAppearance.selected.iconColor = .label
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    /// Configures the global appearance of the `UINavigationBar`.
    /// - Applies the system label color as the default tint color
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .label
    }
    
}
