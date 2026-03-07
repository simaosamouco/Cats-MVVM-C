//
//  FloatingButton.swift
//  Cats
//
//  Created by Simão Neves Samouco on 10/09/2025.
//

import SwiftUI

/// Should be used inside a `ZStack`
struct FloatingButton: View {
    
    var image: Image
    var action: () -> Void
    
    var body: some View {
        button
            .padding([.trailing, .bottom], Measures.Spacing.wide)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
    }
    
    // MARK: Subviews
    
    private var button: some View {
        Button(action: action) {
            image
                .font(.title2)
                .foregroundColor(.primary)
                .frame(width: Measures.Size.xxLarge, height: Measures.Size.xxLarge)
                .background(buttonBackground)
        }
    }
    
    private var buttonBackground: some View {
        Circle()
            .fill(.ultraThinMaterial)
            .overlay(
                Circle()
                    .strokeBorder(.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.25),
                radius: Measures.CornerRadius.medium,
                x: 0,
                y: Measures.Spacing.compact
            )
    }
    
}
#Preview {
    FloatingButton(image: Image(systemName: "bookmark"),
                   action: { print("tapped") })
}
