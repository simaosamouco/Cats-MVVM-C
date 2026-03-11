//
//  CatCell.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

import SwiftUI

struct CatCell<ViewModel: CatCellViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var imageLoaded = false
    
    var body: some View {
        VStack(spacing: Measures.Spacing.tight) {
            imageContainer
            breedNameLabel
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
    
    // MARK: Subviews
    
    private var imageContainer: some View {
        RoundedRectangle(cornerRadius: Measures.CornerRadius.xLarge)
            .fill(.background)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                ZStack {
                    loadingIndicator
                    if let image = viewModel.image {
                        catImage(image)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: Measures.CornerRadius.xLarge))
            )
            .onAppear {
                if viewModel.image == nil {
                    imageLoaded = false
                    viewModel.loadImage()
                }
            }
    }
    
    private var loadingIndicator: some View {
        ProgressView()
            .scaleEffect(1.2)
            .opacity(viewModel.image == nil ? 1 : 0)
            .animation(.easeOut(duration: 0.3), value: viewModel.image == nil)
    }
    
    private func catImage(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(
                color: .black.opacity(0.2),
                radius: Measures.CornerRadius.small,
                x: 0,
                y: Measures.Spacing.hairline
            )
            .opacity(imageLoaded ? 1 : 0)
            .scaleEffect(imageLoaded ? 1 : 0.95)
            .blur(radius: imageLoaded ? 0 : Measures.Spacing.compact)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    imageLoaded = true
                }
            }
            .onChange(of: viewModel.image) { _, newImage in
                if newImage == nil { imageLoaded = false }
            }
    }
    
    private var breedNameLabel: some View {
        Text(viewModel.breedName)
            .font(.caption)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .foregroundColor(.primary)
            .opacity(viewModel.image != nil ? 1 : 0.6)
    }
    
}
