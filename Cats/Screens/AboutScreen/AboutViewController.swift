//
//  AboutViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import SwiftUI

final class AboutViewController<ViewModel: AboutViewModelProtocol>: ThemeHostingController<AboutView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: AboutView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
