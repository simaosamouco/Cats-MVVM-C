//
//  Theme.swift
//  Cats
//
//  Created by Simão Neves Samouco on 31/08/2025.
//

/// Defines app appearance themes and maps them to iOS interface styles.

import Foundation

/// Represents the app's selectable appearance themes.
///
/// The `value` of each case matches the corresponding native `UIUserInterfaceStyle` raw value:
///   - system = 0 (`.unspecified`)
///   - light = 1 (`.light`)
///   - dark = 2 (`.dark`)
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
    
    /// The integer value corresponding to `UIUserInterfaceStyle` (`.unspecified`, `.light`, `.dark`).
    /// Used for bridging with UIKit APIs and persistence.
    var value: Int {
        switch self {
        case .light: return 1
        case .dark: return 2
        case .system: return 0
        }
    }
    
}
