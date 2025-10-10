//
//  TestRoute.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//


enum TestRoute: Route {
    case test(isModallyPresented: Bool)
    
    typealias Factory = TestRouteBuilder
    
    var feature: AppFeature {
        return .test
    }
}
