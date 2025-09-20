//
//  CatsListView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import SwiftUI

struct CatsListView<ViewModel: CatsListViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @FocusState private var isFocused: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
                    TextField("catsList.textField.placeholder".localized,
                              text: $viewModel.searchText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isFocused ? .blue : .gray, lineWidth: 2)
                                .animation(.easeInOut(duration: 0.3), value: isFocused)
                        )
                        .scaleEffect(isFocused ? 1.05 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFocused)
                        .focused($isFocused)
                        //.padding()
                        .padding(.horizontal, Measures.Spacing.medium)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: Measures.Spacing.medium) {
                            ForEach(viewModel.publishedCats, id: \.id) { catCellViewModel in
                                CatCell(viewModel: catCellViewModel)
                                    .onAppear { viewModel.didShowCat(catCellViewModel) }
                                    .onTapGesture { viewModel.didTapCat(catCellViewModel) }
                            }
                        }
                        .padding(.horizontal, Measures.Spacing.medium)
                        .padding(.top, Measures.Spacing.medium)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.publishedCats.count)
                        
                        if viewModel.isLoadingPagination {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .padding(.vertical, Measures.Spacing.regular)
                                Spacer()
                            }
                            .padding(.bottom, Measures.Spacing.gigantic)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            FloatingButton(
                image: Image(systemName: "bookmark"),
                action: { viewModel.didTapBookmarkButton() }
            )
            .symbolEffect(.pulse)
        }
    }
    
}
