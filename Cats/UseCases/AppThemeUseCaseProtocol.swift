//
//  AppThemeUseCaseProtocol.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 13/09/2025.
//

import Foundation
import UIKit

/// A protocol defining the use cases for handling the app's theme.
protocol AppThemeUseCaseProtocol {
    /// Retrieves the current theme applied in the app.
    /// - Returns: The current `Theme`.
    func getCurrentTheme() -> Theme
    
    /// Switches the app to a new theme and persists the selection.
    /// - Parameter theme: The `Theme` to apply.
    func switchTheme(to theme: Theme)
}

/// A concrete implementation of `AppThemeUseCaseProtocol`
/// that manages retrieving and updating the app's theme.
/// It persists the selected theme in the local configuration.
final class AppThemeUseCase: AppThemeUseCaseProtocol {
    
    private let localConfig: LocalConfigUseCaseProtocol
    
    init(localConfig: LocalConfigUseCaseProtocol) {
        self.localConfig = localConfig
    }
    
    /// Retrieves the current theme applied in the app.
    ///
    /// It fetches the raw value from the local configuration.
    /// If no value is found, it defaults to `.system`.
    /// - Returns: The current `Theme`.
    func getCurrentTheme() -> Theme {
        let raw: Int = localConfig.get(for: .appTheme, as: Int.self) ?? Theme.system.value
        return Theme.allCases.first { $0.value == raw } ?? .system
    }
    
    /// Switches the app to a new theme and persists it.
    ///
    /// This method:
    /// 1. Applies the theme immediately to the active window.
    /// 2. Saves the theme to local storage for use on app launch.
    /// - Parameter theme: The `Theme` to apply.
    func switchTheme(to theme: Theme) {
        applyTheme(UIUserInterfaceStyle(rawValue: theme.value) ?? .light)
        /// Saves `Theme` in local config to use on app launch.
        localConfig.set(theme.value, for: .appTheme)
    }
    
    private func applyTheme(_ style: UIUserInterfaceStyle) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = style
        }
    }
}
