//
//  String+Extension.swift
//  Cats
//
//  Created by Simão Neves Samouco on 29/08/2025.
//

import Foundation

extension String {
    
    /// Returns the localized version of the string key.
    ///
    /// - Note: This looks up the string in your app’s `.strings` files using `NSLocalizedString`.
    /// If no localized value is found, it returns the key itself.
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    /// Returns a localized string formatted with the provided arguments.
    ///
    /// - Parameter arguments: A variadic list of values to substitute into the localized format string.
    /// - Returns: A localized and formatted `String`.
    ///
    /// - Example:
    /// ```swift
    /// let greeting = "Hello %@".localized(with: "World")
    /// // "Hello World" (after localization)
    /// ```
    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
    
    /// Returns a localized string interpreted as Markdown and converted into an `AttributedString`.
    ///
    /// - If the localized string contains valid Markdown, it will be parsed and styled accordingly.
    /// - If parsing fails, the method falls back to a plain `AttributedString` with the localized text.
    ///
    /// This is useful when you want to present localized strings with bold, italic,
    /// links, or other Markdown-supported formatting in UI elements like `Text`.
    ///
    /// - Example:
    /// ```swift
    /// let markdown = "**Bold text**".localizedMarkdown
    /// Text(markdown) // renders bold in SwiftUI
    /// ```
    var localizedMarkdown: AttributedString {
        (try? AttributedString(markdown: self.localized)) ?? AttributedString(self.localized)
    }
    
}
