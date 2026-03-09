//
//  ProfileView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import SwiftUI

struct ProfileView<ViewModel: ProfileViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: Measures.Spacing.regular) {
                if let image = viewModel.image {
                    profileContent(for: image)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .animation(.default, value: viewModel.showContent)
        }
        .scrollIndicators(.hidden)
        .toolbar {
            saveButton
        }
        .onAppear {
            viewModel.checkCatSavedStatus()
        }
    }
    
    @ViewBuilder
    private func profileContent(for image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: Measures.Size.mini, y: Measures.Size.mini)
            .transition(
                .opacity
                .animation(.easeOut(duration: 0.8))
            )
        
        Text(viewModel.breedName)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .multilineTextAlignment(.center)
            .transition(
                .opacity.combined(with: .offset(y: Measures.Size.xxLarge))
                .animation(.easeOut(duration: 0.3).delay(0.2))
            )
            .padding(.top, Measures.Spacing.regular)
        
        Text(viewModel.breedDescription)
            .multilineTextAlignment(.center)
            .transition(
                .opacity
                .combined(with: .offset(y: Measures.Size.xxLarge))
                .animation(.easeOut(duration: 0.4).delay(0.3))
            )
            .padding([.top, .horizontal], Measures.Spacing.regular)
        
        Spacer(minLength: 0)
    }
    
    private var saveButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.didTapSaveButton()
            } label: {
                viewModel.toolBarImage
            }
        }
    }

}
