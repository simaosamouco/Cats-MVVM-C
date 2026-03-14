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
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isLoading {
                    loader
                } else {
                    searchTextField
                    ScrollView {
                        catsList
                        if viewModel.isLoadingPagination {
                            paginationLoader
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            bookMarkButton
        }
        .onFirstAppear {
            viewModel.onFirstAppear()
        }
        .navigationTitle("catsList.title".localized)
    }
    
    // MARK: Subviews
    
    private var searchTextField: some View {
        HStack {
            TextField("catsList.textField.placeholder".localized,
                      text: $viewModel.searchText)
                .focused($isFocused)
            
            if !viewModel.searchText.isEmpty {
                clearButton
            }
        }
        .padding()
        .background(textFieldBackground)
        .scaleEffect(isFocused ? 1.05 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFocused)
        .animation(.easeInOut(duration: 0.2), value: viewModel.searchText.isEmpty)
        .padding(.horizontal, Measures.Spacing.medium)
    }

    private var clearButton: some View {
        Button {
            viewModel.didTapClearTextFieldButton()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
        }
        .transition(.scale.combined(with: .opacity))
    }

    private var textFieldBackground: some View {
        RoundedRectangle(cornerRadius: Measures.CornerRadius.xLarge)
            .stroke(isFocused ? .blue : .gray, lineWidth: 2)
            .animation(.easeInOut(duration: 0.3), value: isFocused)
    }
    
    private var bookMarkButton: some View {
        FloatingButton(
            image: Image(systemName: "bookmark"),
            action: { viewModel.didTapBookmarkButton() }
        )
        .symbolEffect(.pulse)
    }
    
    private var paginationLoader: some View {
        HStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
                .padding(.vertical, Measures.Spacing.regular)
            Spacer()
        }
        .padding(.bottom, Measures.Spacing.gigantic)
    }
    
    private var catsList: some View {
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
    }
    
    private var loader: some View {
        ProgressView()
            .scaleEffect(1.5)
    }
    
}
