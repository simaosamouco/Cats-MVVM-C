//
//  Theme.swift
//  Cats
//
//  Created by Simão Neves Samouco on 31/08/2025.
//

/// Defines app appearance themes and maps them to iOS interface styles.

import UIKit

/// Represents the app's selectable appearance themes.
/// This mapping ensures seamless integration with UIKit's style system.
enum Theme: String, CaseIterable, Codable {
    
    /// Follows the system-wide appearance setting.
    case system
    /// Forces light appearance.
    case light
    /// Forces dark appearance.
    case dark
    
    /// Returns a localized display name for each theme.
    var displayName: String {
        switch self {
        case .light: return "appTheme.displayName.light".localized
        case .dark: return "appTheme.displayName.dark".localized
        case .system: return "appTheme.displayName.system".localized
        }
    }
    
    /// The corresponding `UIUserInterfaceStyle` raw value for this theme.
    ///
    /// Maps each case to its `UIKit` equivalent:
    /// - `.light` → `UIUserInterfaceStyle.light`
    /// - `.dark` → `UIUserInterfaceStyle.dark`
    /// - `.system` → `UIUserInterfaceStyle.unspecified`
    var value: Int {
        switch self {
        case .light: return UIUserInterfaceStyle.light.rawValue
        case .dark: return UIUserInterfaceStyle.dark.rawValue
        case .system: return UIUserInterfaceStyle.unspecified.rawValue
        }
    }
    
}
