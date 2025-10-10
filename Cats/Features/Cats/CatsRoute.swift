//
//  CatsRoute.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//


/// Routes available in the Cats feature
enum CatsRoute: Route {
    
    case catListAPI
    case savedCats
    case catProfile
    
    typealias Factory = CatsRouteBuilder
    
    var feature: AppFeature {
        return .cats
    }
    
}
