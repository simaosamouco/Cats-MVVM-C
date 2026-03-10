//
//  SavedCatsViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import SwiftUI

final class SavedCatsViewController<ViewModel: SavedCatsViewModelProtocol>: ThemeHostingController<SavedCatsView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: SavedCatsView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
