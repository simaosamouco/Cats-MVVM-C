//
//  CatsListViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import SwiftUI

final class CatsListViewController<ViewModel: CatsListViewModelProtocol>: ThemeHostingController<CatsListView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: CatsListView(viewModel: viewModel))
        viewModel.getCats(for: .initial)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
