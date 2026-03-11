//
//  SettingsViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import Foundation

final class SettingsViewController<ViewModel: SettingsViewModelProtocol>: ThemeHostingController<SettingsView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: SettingsView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
