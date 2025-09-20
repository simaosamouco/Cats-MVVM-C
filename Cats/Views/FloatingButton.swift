//
//  FloatingButton.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 10/09/2025.
//

import SwiftUI

/// Should be used inside a `ZStack`
struct FloatingButton: View {
    
    var image: Image
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    image
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: Measures.Size.xxLarge,
                               height: Measures.Size.xxLarge)
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    Circle()
                                        .strokeBorder(.white.opacity(0.3), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.25),
                                        radius: Measures.CornerRadius.medium,
                                        x: 0,
                                        y: Measures.Spacing.compact)
                        )
                }
                .padding([.trailing, .bottom], Measures.Spacing.wide)
            }
        }
    }
}

#Preview {
    FloatingButton(image: Image(systemName: "bookmark"),
                   action: { print("tapped") })
}
