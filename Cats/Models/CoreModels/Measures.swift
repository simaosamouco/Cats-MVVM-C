//
//  Measures.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/09/2025.
//

import Foundation

/// A collection of standard design measures used in the app.
///
/// `Measures` provides consistent values for `Size` (width, height and dimensions)
/// and `Spacing` (padding, margins and gaps).
///
/// Example usage:
/// ```swift
/// let buttonHeight = Measures.Size.large
/// let cardPadding = Measures.Spacing.medium
/// ```
enum Measures {
    
    /// Defines common **sizes** (e.g., icons, controls, containers).
    enum Size {
        /// 1pt
        static let micro: CGFloat = 1.0
        /// 2pt
        static let tiny: CGFloat = 2.0
        /// 4pt
        static let mini: CGFloat = 4.0
        /// 6pt
        static let xxSmall: CGFloat = 6.0
        /// 8pt
        static let xSmall: CGFloat = 8.0
        /// 12pt
        static let small: CGFloat = 12.0
        /// 16pt
        static let medium: CGFloat = 16.0
        /// 20pt
        static let mediumLarge: CGFloat = 20.0
        /// 24pt
        static let large: CGFloat = 24.0
        /// 32pt
        static let xLarge: CGFloat = 32.0
        /// 48pt
        static let xxLarge: CGFloat = 48.0
        /// 64pt
        static let xxxLarge: CGFloat = 64.0
        /// 96pt
        static let huge: CGFloat = 96.0
        /// 128pt
        static let gigantic: CGFloat = 128.0
        /// 160pt
        static let colossal: CGFloat = 160.0
        /// 200pt
        static let monumental: CGFloat = 200.0
    }
    
    /// Defines common **spacing values** (e.g., padding, margins, gaps).
    enum Spacing {
        /// 1pt
        static let hairline: CGFloat = 1.0
        /// 2pt
        static let ultraTight: CGFloat = 2.0
        /// 4pt
        static let tight: CGFloat = 4.0
        /// 6pt
        static let compact: CGFloat = 6.0
        /// 8pt
        static let small: CGFloat = 8.0
        /// 12pt
        static let medium: CGFloat = 12.0
        /// 16pt
        static let regular: CGFloat = 16.0
        /// 20pt
        static let wide: CGFloat = 20.0
        /// 24pt
        static let xWide: CGFloat = 24.0
        /// 32pt
        static let xxWide: CGFloat = 32.0
        /// 40pt
        static let xxxWide: CGFloat = 40.0
        /// 56pt
        static let huge: CGFloat = 56.0
        /// 72pt
        static let massive: CGFloat = 72.0
        /// 96pt
        static let gigantic: CGFloat = 96.0
    }
    
    /// Defines common **corner radius values** (e.g., buttons, cards, modals).
    enum CornerRadius {
        /// 2pt
        static let small: CGFloat = 2.0
        /// 4pt
        static let medium: CGFloat = 4.0
        /// 8pt
        static let large: CGFloat = 8.0
        /// 12pt
        static let xLarge: CGFloat = 12.0
        /// 16pt
        static let xxLarge: CGFloat = 16.0
        /// 24pt
        static let pill: CGFloat = 24.0
        /// Half of height/width (for circles).
        static func circle(for size: CGFloat) -> CGFloat {
            return size / 2
        }
    }
    
}
