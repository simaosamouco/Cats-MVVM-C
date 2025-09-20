//
//  AboutView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import SwiftUI

struct AboutView<ViewModel: AboutViewModelProtocol>: View  {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Measures.Spacing.regular) {
                Text("about.title".localized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, Measures.Spacing.tight)
                
                Text("about.subtitle".localized)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("about.contentText.first".localizedMarkdown)
                    .font(.system(size: Measures.Size.medium))
                
                Text("about.contentText.second".localizedMarkdown)
                    .font(.system(size: Measures.Size.medium))
                
                Text("about.contentText.third".localizedMarkdown)
                    .font(.system(size: Measures.Size.medium))
                
                Text("about.contentText.fourth".localizedMarkdown)
                    .font(.system(size: Measures.Size.medium))
                
            }
            .padding()
            
            VStack(alignment: .leading, spacing: .zero) {
                Text("about.navigationBox.title".localized)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding()

                VStack(spacing: Measures.Spacing.small) {
                    SettingsRow(title: "Modal") { viewModel.didTapModalButton() }
                    SettingsRow(title: "Modal full screen") { viewModel.didTapFullScreenModalButton() }
                    SettingsRow(title: "Push") { viewModel.didTapPushButton() }
                    SettingsRow(title: "Change Tab") { viewModel.didTapChangeTabButton() }
                }
                .padding(Measures.Spacing.small)
            }
            .background(
                RoundedRectangle(cornerRadius: Measures.CornerRadius.xxLarge, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .padding()
            
        }
    }
    
}

#if DEBUG

final class PreviewAboutViewModel: AboutViewModelProtocol, ObservableObject {
    func didTapModalButton() {}
    func didTapFullScreenModalButton() {}
    func didTapPushButton() {}
    func didTapChangeTabButton() {}
}

#Preview("AboutView") {
    AboutView(viewModel: PreviewAboutViewModel())
}

#endif
