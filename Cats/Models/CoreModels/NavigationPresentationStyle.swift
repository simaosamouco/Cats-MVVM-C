//
//  NavigationPresentationStyle.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/10/2025.
//


/// Defines different ways a screen can be presented
enum NavigationPresentationStyle {
    case push(hideTabBar: Bool)
    case present
    case presentFullscreen
    case setAsRoot
}