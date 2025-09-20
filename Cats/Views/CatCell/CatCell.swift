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
            RoundedRectangle(cornerRadius: Measures.CornerRadius.xLarge)
                .fill(.background)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    ZStack {
                        ProgressView()
                            .scaleEffect(1.2)
                            .opacity(viewModel.image == nil ? 1 : 0)
                            .animation(.easeOut(duration: 0.3), value: viewModel.image == nil)
                        
                        if let image = viewModel.image {
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
                                    withAnimation(.spring(response: 0.6,
                                                          dampingFraction: 0.8)) {
                                        imageLoaded = true
                                    }
                                }
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
            
            Text(viewModel.breedName)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(.primary)
                .opacity(viewModel.image != nil ? 1 : 0.6)
                .animation(
                    .easeInOut(duration: 0.4)
                        .delay(viewModel.image != nil ? 0.2 : 0),
                    value: viewModel.image != nil
                )
        }
    }
}

final class MockCatCellViewModel: CatCellViewModelProtocol, ObservableObject {
    @Published var image: UIImage? = UIImage(systemName: "pawprint.fill")
    let breedName: String
    let id: String = UUID().uuidString
    
    init(breedName: String) {
        self.breedName = breedName
    }
    
    func loadImage() {
        // Simulate async image loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.image = UIImage(systemName: "pawprint.fill")
        }
    }
}

struct CatCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            CatCell(viewModel: MockCatCellViewModel(breedName: "Siamese"))
                .frame(width: 120)
            
            CatCell(viewModel: MockCatCellViewModel(breedName: "Maine Coon"))
                .frame(width: 120)
            
            CatCell(viewModel: MockCatCellViewModel(breedName: "Persian"))
                .frame(width: 120)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
