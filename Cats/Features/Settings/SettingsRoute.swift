//
//  SettingsRoute.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

import Foundation

enum SettingsRoute: Route {
    case settings
    case about
    
    typealias Factory = SettingsRouteBuilder
    
    var feature: AppFeature {
        return .settings
    }
}
