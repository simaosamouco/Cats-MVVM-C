//
//  UIViewControllerWrapper.swift
//  Cats
//
//  Created on 24/09/2025.
//

import SwiftUI
import UIKit

/// A SwiftUI wrapper that allows embedding UIViewController instances within SwiftUI views.
/// This enables gradual migration from UIKit to SwiftUI while preserving existing view controllers.
/// Now includes theme change detection to refresh UIKit content when themes change.
struct UIViewControllerWrapper<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
    
    // Environment values to detect changes
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeObserver: ThemeObserver
    
    init(_ viewController: T) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> T {
        // Apply initial theme
        applyCurrentTheme()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
        // This is called when SwiftUI environment changes (like theme)
        applyCurrentTheme()
        
        // Force the view controller to refresh its appearance
        refreshViewControllerAppearance(uiViewController)
    }
    
    private func applyCurrentTheme() {
        // Ensure the current theme is applied to UIKit components
        DispatchQueue.main.async {
            // Get the current theme from the observer
            let currentTheme = themeObserver.currentTheme
            
            // Force UIKit to use the current interface style
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                
                let style = UIUserInterfaceStyle(rawValue: currentTheme.value) ?? .unspecified
                window.overrideUserInterfaceStyle = style
            }
        }
    }
    
    private func refreshViewControllerAppearance(_ viewController: T) {
        // Force the view controller and its children to refresh their appearance
        DispatchQueue.main.async {
            viewController.setNeedsStatusBarAppearanceUpdate()
            
            // Recursively refresh all child view controllers
            refreshViewControllerHierarchy(viewController)
            
            // Force view to layout with new theme
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
            
            // Trigger appearance callbacks
            viewController.viewWillAppear(false)
            
            // Refresh navigation controller appearance if applicable
            if let navController = viewController as? UINavigationController {
                refreshNavigationControllerAppearance(navController)
            } else if let navController = viewController.navigationController {
                refreshNavigationControllerAppearance(navController)
            }
        }
    }
    
    private func refreshViewControllerHierarchy(_ viewController: UIViewController) {
        // Refresh current view controller
        viewController.view.setNeedsDisplay()
        
        // Refresh all child view controllers
        for child in viewController.children {
            refreshViewControllerHierarchy(child)
        }
        
        // If it's a navigation controller, refresh all view controllers in the stack
        if let navController = viewController as? UINavigationController {
            for vc in navController.viewControllers {
                refreshViewControllerHierarchy(vc)
            }
        }
        
        // If it's a tab bar controller, refresh all tabs
        if let tabController = viewController as? UITabBarController {
            for vc in tabController.viewControllers ?? [] {
                refreshViewControllerHierarchy(vc)
            }
        }
    }
    
    private func refreshNavigationControllerAppearance(_ navController: UINavigationController) {
        // Force navigation bar to update its appearance
        let appearance = navController.navigationBar.standardAppearance
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        // Force toolbar to update if present
        if let toolbar = navController.toolbar {
            toolbar.setNeedsLayout()
            toolbar.layoutIfNeeded()
        }
    }
}

/// Enhanced wrapper that can recreate view controllers when theme changes
/// Use this for view controllers that need complete recreation on theme change
struct RefreshableUIViewControllerWrapper<T: UIViewController>: UIViewControllerRepresentable {
    let viewControllerFactory: () -> T
    
    // Environment values to detect changes
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeObserver: ThemeObserver
    
    init(factory: @escaping () -> T) {
        self.viewControllerFactory = factory
    }
    
    func makeUIViewController(context: Context) -> T {
        let viewController = viewControllerFactory()
        applyCurrentTheme(to: viewController)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
        // Apply current theme and refresh appearance
        applyCurrentTheme(to: uiViewController)
        refreshViewControllerAppearance(uiViewController)
    }
    
    private func applyCurrentTheme(to viewController: T) {
        // Ensure the current theme is applied to UIKit components
        DispatchQueue.main.async {
            // Get the current theme from the observer
            let currentTheme = themeObserver.currentTheme
            
            // Force UIKit to use the current interface style
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                
                let style = UIUserInterfaceStyle(rawValue: currentTheme.value) ?? .unspecified
                window.overrideUserInterfaceStyle = style
            }
        }
    }
    
    private func refreshViewControllerAppearance(_ viewController: T) {
        // Force the view controller and its children to refresh their appearance
        DispatchQueue.main.async {
            viewController.setNeedsStatusBarAppearanceUpdate()
            
            // Recursively refresh all child view controllers
            refreshViewControllerHierarchy(viewController)
            
            // Force view to layout with new theme
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
            
            // Trigger appearance callbacks
            viewController.viewWillAppear(false)
            
            // Refresh navigation controller appearance if applicable
            if let navController = viewController as? UINavigationController {
                refreshNavigationControllerAppearance(navController)
            } else if let navController = viewController.navigationController {
                refreshNavigationControllerAppearance(navController)
            }
        }
    }
    
    private func refreshViewControllerHierarchy(_ viewController: UIViewController) {
        // Refresh current view controller
        viewController.view.setNeedsDisplay()
        
        // Refresh all child view controllers
        for child in viewController.children {
            refreshViewControllerHierarchy(child)
        }
        
        // If it's a navigation controller, refresh all view controllers in the stack
        if let navController = viewController as? UINavigationController {
            for vc in navController.viewControllers {
                refreshViewControllerHierarchy(vc)
            }
        }
        
        // If it's a tab bar controller, refresh all tabs
        if let tabController = viewController as? UITabBarController {
            for vc in tabController.viewControllers ?? [] {
                refreshViewControllerHierarchy(vc)
            }
        }
    }
    
    private func refreshNavigationControllerAppearance(_ navController: UINavigationController) {
        // Force navigation bar to update its appearance
        let appearance = navController.navigationBar.standardAppearance
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        // Force toolbar to update if present
        if let toolbar = navController.toolbar {
            toolbar.setNeedsLayout()
            toolbar.layoutIfNeeded()
        }
    }
}
