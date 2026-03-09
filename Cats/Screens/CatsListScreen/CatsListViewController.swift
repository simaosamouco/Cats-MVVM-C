//
//  CatsListViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import SwiftUI

final class CatsListViewController<Content: View>: ThemeHostingController<Content> {
    
    private weak var viewModel: (any CatsListViewModelProtocol)?

    init(view: Content,
         viewModel: some CatsListViewModelProtocol) {
        super.init(rootView: view)
        viewModel.getCats(for: .initial)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
