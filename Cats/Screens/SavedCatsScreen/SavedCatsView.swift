//
//  SavedCatsView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import SwiftUI

struct SavedCatsView<ViewModel: SavedCatsViewModelProtocol>: View  {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var isGridView = true
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let listColumns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    }
                    
                    if viewModel.cats.isEmpty {
                        VStack(spacing: Measures.Spacing.regular) {
                            Spacer()
                            Image(systemName: "bookmark.slash")
                                .resizable()
                                .frame(width: Measures.Size.huge, height: Measures.Size.huge)
                            Text("savedCats.emptyState.title".localized)
                                .font(.headline)
                            Text("savedCats.emptyState.subtitle".localized)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, Measures.Spacing.xWide)
                        }
                        .scrollDisabled(true)
                    } else {
                        LazyVGrid(columns: isGridView ? columns : listColumns,
                                  spacing: Measures.Spacing.small) {
                            ForEach(viewModel.cats, id: \.id) { catCellViewModel in
                                CatCell(viewModel: catCellViewModel)
                                    .onTapGesture {
                                        viewModel.didTapCat(catCellViewModel)
                                    }
                            }
                        }
                        .padding(.horizontal, Measures.Spacing.regular)
                        .padding(.top, Measures.Spacing.regular)
                    }
                }
            }
            
            // Floating button
            if !viewModel.cats.isEmpty {
                FloatingButton(
                    image: isGridView ? Image(systemName: "list.bullet") : Image(systemName: "square.grid.3x3"),
                    action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isGridView.toggle()
                        }
                    }
                )
                .contentTransition(.symbolEffect(.automatic))
            }
        }
        .onAppear {
            viewModel.getSavedCats()
        }
    }
}

