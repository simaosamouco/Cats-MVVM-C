//
//  ProfileView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import SwiftUI

struct ProfileView<ViewModel: ProfileViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showContent = false
    
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
        }
        .scrollIndicators(.hidden)
        .onChange(of: viewModel.image) { _, newImage in
            handleImageChange(newImage)
        }
    }
    
    @ViewBuilder
    private func profileContent(for image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: Measures.Size.mini, y: Measures.Size.mini)
            .opacity(showContent ? 1 : 0)
            .animation(.easeOut(duration: 0.8), value: showContent)
        
        Text(viewModel.breedName)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .multilineTextAlignment(.center)
            .offset(y: showContent ? 0 : Measures.Size.xxLarge)
            .opacity(showContent ? 1 : 0)
            .animation(.easeOut(duration: 0.3).delay(0.2), value: showContent)
            .padding(.top, Measures.Spacing.regular)
        
        Text(viewModel.breedDescription)
            .multilineTextAlignment(.center)
            .offset(y: showContent ? 0 : Measures.Size.xxLarge)
            .opacity(showContent ? 1 : 0)
            .blur(radius: showContent ? 0 : Measures.Spacing.tight)
            .animation(.easeOut(duration: 0.4).delay(0.3), value: showContent)
            .padding([.top, .horizontal], Measures.Spacing.regular)
        
        Spacer(minLength: 0)
    }
    
    private func handleImageChange(_ newImage: UIImage?) {
        showContent = (newImage != nil)
    }

}
