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
struct UIViewControllerWrapper<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
    
    init(_ viewController: T) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> T {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
        // Updates can be handled here if needed
    }
}