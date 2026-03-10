//
//  ProfileViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import SwiftUI

final class ProfileViewController<ViewModel: ProfileViewModelProtocol>: ThemeHostingController<ProfileView<ViewModel>> {
    
    init(viewModel: ViewModel) {
        super.init(rootView: ProfileView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
