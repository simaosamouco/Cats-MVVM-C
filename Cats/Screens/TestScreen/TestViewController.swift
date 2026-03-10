//
//  TestViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import SwiftUI

final class TestViewController<ViewModel: TestViewModelProtocol>: ThemeHostingController<TestView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: TestView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
