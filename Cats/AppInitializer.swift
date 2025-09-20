//
//  AppInitializer.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import UIKit

final class AppInitializer {
    
    private let appThemeUseCase: AppThemeUseCaseProtocol
    
    init(appThemeUseCase: AppThemeUseCaseProtocol) {
        self.appThemeUseCase = appThemeUseCase
    }

    func configureAppTheme() {
        let theme = appThemeUseCase.getCurrentTheme()
        appThemeUseCase.switchTheme(to: theme)
    }
    
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
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .label
    }
    
}
