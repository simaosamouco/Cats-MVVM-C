//
//  SettingsRow.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import SwiftUI

struct SettingsRow: View {
    
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
                    .font(.system(size: Measures.Size.small, weight: .semibold))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Measures.CornerRadius.xLarge, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
        }
        .buttonStyle(.plain)
    }
    
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            SettingsRow(title: "Profile") {
                print("Profile tapped")
            }
            
            SettingsRow(title: "Notifications") {
                print("Notifications tapped")
            }
            
            SettingsRow(title: "Privacy") {
                print("Privacy tapped")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
