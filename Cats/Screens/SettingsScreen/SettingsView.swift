//
//  SettingsView.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: Measures.Spacing.medium) {
                
                Image(systemName: "cat.circle")
                    .resizable()
                    .frame(
                        width: Measures.Size.xxxLarge,
                        height: Measures.Size.xxxLarge
                    )
                
                VStack(alignment: .leading, spacing: Measures.Spacing.small) {
                    Text("settings.themeRow".localized)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Picker("Theme", selection: $viewModel.selectedTheme) {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(Measures.Spacing.medium)
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(
                        cornerRadius: Measures.CornerRadius.xLarge
                    )
                )
                .onChange(of: viewModel.selectedTheme) {
                    viewModel.didSwitchTheme(to: viewModel.selectedTheme)
                }
                .shadow(
                    color: .black.opacity(0.3),
                    radius: Measures.CornerRadius.medium,
                    x: 0,
                    y: Measures.Spacing.compact
                )
                
                SettingsRow(title: "settings.aboutRow".localized) {
                    viewModel.didTapAboutRow()
                }
                
                Spacer()
            }
            .padding(.top, Measures.Spacing.regular)
            .padding(.horizontal, Measures.Spacing.medium)
        }
    }
}


#if DEBUG
// MARK: - Mock ViewModel for Preview
final class MockSettingsViewModel: SettingsViewModelProtocol {
    @Published var selectedTheme: Theme = .system
    func didSwitchTheme(to theme: Theme) {}
    func didTapAboutRow() {}
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: MockSettingsViewModel())
            .previewDisplayName("Settings Preview")
    }
}
#endif

