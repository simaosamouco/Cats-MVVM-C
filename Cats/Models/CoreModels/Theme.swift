//
//  Theme.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 31/08/2025.
//


enum Theme: String, CaseIterable, Codable {
    
    case light, dark, system
    
    var displayName: String {
        switch self {
        case .light: return "appTheme.displayName.light".localized
        case .dark: return "appTheme.displayName.dark".localized
        case .system: return "appTheme.displayName.system".localized
        }
    }
    
    var value: Int {
        switch self {
        case .light: return 1
        case .dark: return 2
        case .system: return 0
        }
    }
    
}
